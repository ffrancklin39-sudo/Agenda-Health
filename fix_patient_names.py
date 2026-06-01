"""
fix_patient_names.py
Corrige todos os nomes de pacientes no Supabase para Title Case.
Execução: python fix_patient_names.py
"""
import urllib.request, json, re

SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co"
SERVICE_KEY  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODMwMjk1NCwiZXhwIjoyMDgzODc4OTU0fQ.cnD-3_9kfasLNi8W9WMlGmRIJj9JOH8H8wDqP-HFYCc"

HEADERS = {
    "apikey": SERVICE_KEY,
    "Authorization": f"Bearer {SERVICE_KEY}",
    "Content-Type": "application/json",
    "Prefer": "return=minimal",
}

def to_title_case(name: str) -> str:
    """Title case respeitando hífen e artigos comuns."""
    if not name:
        return name
    artigos = {"de", "da", "do", "das", "dos", "e", "em", "a", "o", "as", "os"}
    partes = re.split(r'(\s+|-)', name.strip().lower())
    result = []
    for i, p in enumerate(partes):
        if re.match(r'\s+|-', p):
            result.append(p)
        elif i == 0 or result and result[-1] == '-':
            result.append(p.capitalize())
        elif p in artigos:
            result.append(p)
        else:
            result.append(p.capitalize())
    return "".join(result)

def api(method, path, body=None):
    url = f"{SUPABASE_URL}/rest/v1/{path}"
    data = json.dumps(body).encode() if body else None
    req = urllib.request.Request(url, data=data, headers=HEADERS, method=method)
    with urllib.request.urlopen(req, timeout=30) as r:
        raw = r.read()
        return json.loads(raw) if raw else []

# Busca todos os pacientes em lotes
print("Buscando pacientes...")
all_patients = []
offset = 0
batch = 1000
while True:
    path = f"patients?select=id,name&order=name&offset={offset}&limit={batch}"
    chunk = api("GET", path)
    all_patients.extend(chunk)
    if len(chunk) < batch:
        break
    offset += batch

print(f"Total encontrado: {len(all_patients)} pacientes")

# Filtra só os que precisam de correção
to_fix = [(p["id"], p["name"], to_title_case(p["name"]))
          for p in all_patients
          if p.get("name") and p["name"] != to_title_case(p["name"])]

print(f"Precisam de correção: {len(to_fix)} pacientes")

if not to_fix:
    print("Tudo já está no padrão correto!")
else:
    confirm = input(f"\nCorrigir {len(to_fix)} nomes? (s/n): ").strip().lower()
    if confirm != 's':
        print("Cancelado.")
    else:
        updated = 0
        errors = 0
        for pid, old, new in to_fix:
            try:
                body = {"name": new}
                req = urllib.request.Request(
                    f"{SUPABASE_URL}/rest/v1/patients?id=eq.{pid}",
                    data=json.dumps(body).encode(),
                    headers={**HEADERS, "Prefer": "return=minimal"},
                    method="PATCH"
                )
                urllib.request.urlopen(req, timeout=15)
                updated += 1
                if updated % 100 == 0:
                    print(f"  {updated}/{len(to_fix)} atualizados...")
            except Exception as e:
                errors += 1
                print(f"  ERRO em {pid}: {e}")

        print(f"\nConcluído: {updated} nomes corrigidos, {errors} erros.")
        if errors == 0:
            print("Exemplos corrigidos:")
            for _, old, new in to_fix[:5]:
                print(f"  '{old}' → '{new}'")
