"""
upload_parallel.py
Upload paralelo dos arquivos Feegow → Supabase Storage
Uso: python upload_parallel.py [--limit N]
É retomável: pula arquivos já marcados como uploaded=true no banco.
"""
import json, os, sys, time, mimetypes
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import urllib.request, urllib.error

SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODMwMjk1NCwiZXhwIjoyMDgzODc4OTU0fQ.cnD-3_9kfasLNi8W9WMlGmRIJj9JOH8H8wDqP-HFYCc"
BUCKET      = "patient-files"
BASE_PATH   = Path("/sessions/elegant-jolly-curie/mnt/d457fd08-5b27-41bd-b089-c974a170f56c-backup feegow/Client")
META_FILE   = Path(__file__).parent / "migration_output" / "patient_files_meta.json"
WORKERS     = 15

MIME = {
    "pdf": "application/pdf", "jpg": "image/jpeg", "jpeg": "image/jpeg",
    "png": "image/png", "webp": "image/webp", "gif": "image/gif",
    "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "jfif": "image/jpeg",
}

def supabase_headers(extra=None):
    h = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}
    if extra: h.update(extra)
    return h

def upload_file(storage_path: str, local_path: Path, mime: str) -> bool:
    url = f"{SUPABASE_URL}/storage/v1/object/{BUCKET}/{storage_path}"
    data = local_path.read_bytes()
    headers = supabase_headers({"Content-Type": mime, "x-upsert": "true"})
    req = urllib.request.Request(url, data=data, headers=headers, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            return r.status in (200, 201)
    except urllib.error.HTTPError as e:
        print(f"\n  ❌ HTTP {e.code} for {storage_path}: {e.read()[:100]}")
        return False

def mark_uploaded(record_id: str, storage_path: str):
    url = f"{SUPABASE_URL}/rest/v1/patient_files?id=eq.{record_id}"
    body = json.dumps({"uploaded": True, "storage_path": storage_path}).encode()
    headers = supabase_headers({"Content-Type": "application/json", "Prefer": "return=minimal"})
    req = urllib.request.Request(url, data=body, headers=headers, method="PATCH")
    try:
        urllib.request.urlopen(req, timeout=10)
    except Exception:
        pass

def fetch_already_uploaded() -> set:
    uploaded = set()
    offset = 0
    while True:
        url = f"{SUPABASE_URL}/rest/v1/patient_files?uploaded=eq.true&select=id&limit=1000&offset={offset}"
        req = urllib.request.Request(url, headers=supabase_headers())
        try:
            with urllib.request.urlopen(req, timeout=15) as r:
                rows = json.loads(r.read())
                if not rows: break
                for row in rows: uploaded.add(row["id"])
                if len(rows) < 1000: break
                offset += 1000
        except Exception:
            break
    return uploaded

def process_one(f: dict) -> tuple:
    fname  = f.get("_original_name") or f.get("file_name")
    folder = f.get("folder", "Arquivos")
    local  = BASE_PATH / folder / fname
    if not local.exists():
        return "skip", f["id"], None
    ext  = (f.get("file_type") or local.suffix.lstrip(".")).lower()
    mime = MIME.get(ext, "application/octet-stream")
    sp   = f"patients/{f['patient_id']}/{folder}/{fname}"
    ok   = upload_file(sp, local, mime)
    if ok:
        mark_uploaded(f["id"], sp)
        return "ok", f["id"], sp
    return "err", f["id"], None

def main():
    limit = int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[1] == "--limit" else None
    meta  = json.loads(META_FILE.read_text())

    print(f"\n{'='*55}")
    print(f"  Upload Feegow → Supabase Storage  ({len(meta)} registros)")
    print(f"{'='*55}\n")

    print("  🔍 Verificando já enviados...", end="", flush=True)
    done_ids = fetch_already_uploaded()
    pending  = [f for f in meta if f["id"] not in done_ids]
    print(f" {len(done_ids)} prontos, {len(pending)} pendentes.\n")

    if limit: pending = pending[:limit]

    counts = {"ok": 0, "skip": 0, "err": 0}
    start  = time.time()

    with ThreadPoolExecutor(max_workers=WORKERS) as ex:
        futures = {ex.submit(process_one, f): f for f in pending}
        for fut in as_completed(futures):
            status, fid, sp = fut.result()
            counts[status] += 1
            total = sum(counts.values())
            pct   = round(total / len(pending) * 100) if pending else 100
            elapsed = time.time() - start
            rate  = counts["ok"] / elapsed if elapsed > 0 else 0
            eta   = int((len(pending) - total) / rate) if rate > 0 else 0
            print(
                f"  {pct:3d}% | ✅{counts['ok']} ⏭️{counts['skip']} ❌{counts['err']}"
                f" | {elapsed:.0f}s decorridos | ETA: {eta}s    ",
                end="\r", flush=True
            )

    print(f"\n\n  Concluído em {time.time()-start:.0f}s")
    print(f"  ✅ {counts['ok']} enviados | ⏭️ {counts['skip']} não encontrados | ❌ {counts['err']} erros\n")

if __name__ == "__main__":
    main()
