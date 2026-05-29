"""
migrate_feegow.py — ETL: Backup Feegow → SintesIA (Supabase)

Uso:
    python migrate_feegow.py --zip <caminho_do_zip> --out <pasta_de_saida>

Saída (pasta_de_saida/):
    professionals.csv, services.csv, patients.csv, appointments.csv, id_map.json
"""

import argparse, csv, io, json, sys, uuid, zipfile
from datetime import datetime
from pathlib import Path

APPOINTMENT_STATUS_MAP = {
    "1":"scheduled","2":"confirmed","3":"completed","4":"scheduled",
    "5":"confirmed","6":"cancelled","7":"confirmed","11":"cancelled",
    "15":"scheduled","22":"cancelled","208":"confirmed",
}

def new_uuid(): return str(uuid.uuid4())

def read_csv(zf, name):
    try:
        raw = zf.read(name).decode("utf-8", errors="replace")
    except KeyError:
        print(f"  [AVISO] {name} não encontrado"); return []
    return list(csv.DictReader(io.StringIO(raw)))

def write_csv(path, rows, fieldnames):
    with open(path, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        w.writeheader(); w.writerows(rows)
    print(f"  ✓ {path.name}: {len(rows)} linhas")

def clean(v):
    return "" if v is None else str(v).strip().lstrip("'")

def parse_date(v):
    v = clean(v)
    if not v or v in ("0000-00-00","NULL","null",""): return ""
    try: return datetime.fromisoformat(v.replace("Z","+00:00")).isoformat()
    except: return v

def parse_phone(*fields):
    for f in fields:
        v = clean(f)
        if v and len(v) >= 8: return v
    return ""

def transform_professionals(rows):
    id_map, out = {}, []
    colors = ["blue","purple","emerald","rose","amber"]
    for i, r in enumerate(r for r in rows if clean(r.get("ativo"))=="on" and clean(r.get("sys_active"))=="1"):
        nid = new_uuid(); id_map[clean(r["id"])] = nid
        out.append({"id":nid,"name":clean(r.get("nome_profissional","")),"email":clean(r.get("email1","")),"phone":parse_phone(r.get("celular1",""),r.get("telefone1","")),"specialty":"","color":colors[i%len(colors)],"created_at":clean(r.get("sys_date","")) or datetime.now().isoformat()})
    return out, id_map

def transform_services(rows):
    id_map, out = {}, []
    for r in rows:
        if clean(r.get("sys_active")) != "1": continue
        nome = clean(r.get("nome_procedimento",""))
        if not nome: continue
        nid = new_uuid(); id_map[clean(r["id"])] = nid
        out.append({"id":nid,"name":nome,"price":0.0,"duration_minutes":0,"category":"Consultas","created_at":datetime.now().isoformat()})
    return out, id_map

def patient_status(fid, appt_by_patient):
    appts = appt_by_patient.get(fid, [])
    if not appts: return "lead"
    today = datetime.now().date()
    for a in appts:
        d = a.get("Data","")
        try:
            if d and datetime.fromisoformat(d).date() >= today:
                if a.get("status_id") in ("1","7","4"): return "scheduled"
                if a.get("status_id") in ("2","3","208"): return "confirmed"
        except: pass
    return "confirmed" if any(a.get("status_id")=="3" for a in appts) else "lead"

def transform_patients(rows, appt_by_patient):
    id_map, out = {}, []
    for r in rows:
        if clean(r.get("sys_active")) != "1": continue
        nome = clean(r.get("nome_paciente",""))
        if not nome: continue
        nid = new_uuid(); fid = clean(r["id"]); id_map[fid] = nid
        out.append({"id":nid,"name":nome,"email":clean(r.get("email","")),"phone":parse_phone(r.get("celular",""),r.get("celular_2",""),r.get("fixo_1","")),"cpf":clean(r.get("cpf","")),"status":patient_status(fid,appt_by_patient),"observation":clean(r.get("Observacoes","")),"source":"","created_at":parse_date(r.get("sys_date","")) or datetime.now().isoformat()})
    return out, id_map

def transform_appointments(rows, pat_map, prof_map, svc_map, ap_by_appt):
    out = []
    for r in rows:
        pat_uuid = pat_map.get(clean(r.get("paciente_id","")))
        if not pat_uuid: continue
        prof_uuid = prof_map.get(clean(r.get("profissional_id","")), "")
        svc_uuid = svc_map.get(clean(r.get("procedimento_id","")), "")
        if not svc_uuid:
            for ap in ap_by_appt.get(clean(r["id"]), []):
                svc_uuid = svc_map.get(clean(ap.get("procedimento_id","")), "")
                if svc_uuid: break
        data = clean(r.get("Data","")); hora = clean(r.get("Hora","00:00:00"))
        if not data or data == "0000-00-00": continue
        status = APPOINTMENT_STATUS_MAP.get(clean(r.get("status_id","1")), "scheduled")
        dur = clean(r.get("tempo",""))
        if not dur:
            aps = ap_by_appt.get(clean(r["id"]),[])
            if aps: dur = clean(aps[0].get("tempo",""))
        try: dur_int = int(float(dur)) if dur else 0
        except: dur_int = 0
        val = clean(r.get("valor","0"))
        if not val or val in ("0.00","0"):
            aps = ap_by_appt.get(clean(r["id"]),[])
            if aps: val = clean(aps[0].get("valor","0"))
        try: val_f = float(val) if val else 0.0
        except: val_f = 0.0
        out.append({"id":new_uuid(),"patient_id":pat_uuid,"professional_id":prof_uuid,"service_id":svc_uuid,"date_time":f"{data}T{hora}","duration_minutes":dur_int,"status":status,"notes":clean(r.get("Notas","")),"price":round(val_f,2),"created_at":parse_date(r.get("sys_date","")) or datetime.now().isoformat()})
    return out

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--zip", required=True)
    p.add_argument("--out", default="./migration_output")
    args = p.parse_args()
    zp = Path(args.zip); od = Path(args.out); od.mkdir(parents=True, exist_ok=True)
    if not zp.exists(): print(f"ERRO: {zp} não encontrado"); sys.exit(1)
    print(f"\n{'='*56}\n  Migração Feegow → SintesIA\n  ZIP: {zp}\n  Saída: {od}\n{'='*56}\n")
    zf = zipfile.ZipFile(zp)

    print("📂 Carregando tabelas auxiliares...")
    ap_rows = read_csv(zf, "agendamento_procedimento.csv")
    ap_by_appt = {}
    for ap in ap_rows: ap_by_appt.setdefault(clean(ap.get("agendamento_id","")), []).append(ap)
    ag_rows = read_csv(zf, "agendamentos.csv")
    appt_by_pat = {}
    for a in ag_rows: appt_by_pat.setdefault(clean(a.get("paciente_id","")), []).append(a)

    print("\n👩‍⚕️  Profissionais...")
    profs, prof_map = transform_professionals(read_csv(zf, "profissionais.csv"))
    write_csv(od/"professionals.csv", profs, ["id","name","email","phone","specialty","color","created_at"])

    print("\n🏥  Serviços/Procedimentos...")
    svcs, svc_map = transform_services(read_csv(zf, "procedimentos.csv"))
    price_by_proc = {}
    for ci in read_csv(zf, "conta_itens.csv"):
        pid = clean(ci.get("procedimento_id","")); v = clean(ci.get("valor_unitario",""))
        try:
            vf = float(v)
            if vf > 0: price_by_proc.setdefault(pid,[]).append(vf)
        except: pass
    for s in svcs:
        fid = next((k for k,v in svc_map.items() if v==s["id"]),None)
        if fid and fid in price_by_proc:
            ps = price_by_proc[fid]; s["price"] = round(sum(ps)/len(ps),2)
    write_csv(od/"services.csv", svcs, ["id","name","price","duration_minutes","category","created_at"])

    print("\n👥  Pacientes...")
    pats, pat_map = transform_patients(read_csv(zf, "pacientes.csv"), appt_by_pat)
    write_csv(od/"patients.csv", pats, ["id","name","email","phone","cpf","status","observation","source","created_at"])

    print("\n📅  Agendamentos...")
    appts = transform_appointments(ag_rows, pat_map, prof_map, svc_map, ap_by_appt)
    write_csv(od/"appointments.csv", appts, ["id","patient_id","professional_id","service_id","date_time","duration_minutes","status","notes","price","created_at"])

    with open(od/"id_map.json","w",encoding="utf-8") as f:
        json.dump({"professionals":prof_map,"services":svc_map,"patients":pat_map},f,indent=2,ensure_ascii=False)
    print(f"  ✓ id_map.json salvo")

    print(f"\n{'='*56}")
    print(f"  RESUMO: {len(profs)} profissionais | {len(svcs)} serviços")
    print(f"          {len(pats)} pacientes | {len(appts)} agendamentos")
    print(f"\n  ✅ Importe no Supabase:")
    print(f"     Dashboard → Table Editor → Import data from CSV")
    print(f"{'='*56}\n")
    zf.close()

if __name__ == "__main__":
    main()
