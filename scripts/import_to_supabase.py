"""
import_to_supabase.py
=====================
Importa os CSVs da migração Feegow diretamente no Supabase via API REST.

Pré-requisito:
    pip install requests

Uso:
    python import_to_supabase.py

Os CSVs devem estar na pasta migration_output/ (mesma pasta deste script).
"""

import csv
import json
import os
import time
from pathlib import Path

try:
    import requests
except ImportError:
    print("❌ Instale o requests primeiro:  pip install requests")
    raise

# ---------------------------------------------------------------------------
# CONFIGURAÇÃO — não precisa alterar nada
# ---------------------------------------------------------------------------
SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDI5NTQsImV4cCI6MjA4Mzg3ODk1NH0.f2rcdjPuxyx2REEviDRObE-Sn1D4ytb4_HwTDjW8Xao"

HEADERS = {
    "apikey":        SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type":  "application/json",
    "Prefer":        "return=minimal",  # mais rápido: não retorna os dados inseridos
}

SCRIPT_DIR = Path(__file__).parent
CSV_DIR    = SCRIPT_DIR / "migration_output"

# Ordem importa: professionals e services antes de patients, patients antes de appointments
IMPORT_ORDER = [
    ("professionals", "professionals.csv"),
    ("services",      "services.csv"),
    ("patients",      "patients.csv"),
    ("appointments",  "appointments.csv"),
]

BATCH_SIZE = 500   # número de linhas por request (Supabase suporta até ~1000)

# ---------------------------------------------------------------------------

def load_csv(path: Path) -> list[dict]:
    with open(path, encoding="utf-8") as f:
        return list(csv.DictReader(f))


def clean_row(row: dict) -> dict:
    """Converte strings vazias para None e garante tipos corretos."""
    cleaned = {}
    for k, v in row.items():
        if v == "" or v is None:
            cleaned[k] = None
        else:
            cleaned[k] = v
    return cleaned


def insert_batch(table: str, rows: list[dict]) -> tuple[bool, str]:
    """Insere um lote de linhas. Retorna (sucesso, mensagem_erro)."""
    url = f"{SUPABASE_URL}/rest/v1/{table}"
    payload = [clean_row(r) for r in rows]
    try:
        r = requests.post(url, headers=HEADERS, data=json.dumps(payload), timeout=30)
        if r.status_code in (200, 201):
            return True, ""
        else:
            return False, f"HTTP {r.status_code}: {r.text[:200]}"
    except requests.exceptions.RequestException as e:
        return False, str(e)


def import_table(table: str, csv_file: Path):
    print(f"\n  Importando {table}...")
    if not csv_file.exists():
        print(f"    ⚠️  Arquivo não encontrado: {csv_file}")
        return

    rows = load_csv(csv_file)
    total   = len(rows)
    success = 0
    errors  = 0

    for i in range(0, total, BATCH_SIZE):
        batch = rows[i : i + BATCH_SIZE]
        ok, err = insert_batch(table, batch)
        if ok:
            success += len(batch)
            pct = int(success / total * 100)
            print(f"    {pct:3d}% — {success}/{total}", end="\r")
        else:
            errors += len(batch)
            print(f"\n    ❌ Erro no lote {i}-{i+len(batch)}: {err}")

        time.sleep(0.1)  # evita rate limiting

    print(f"    ✅ {table}: {success} inseridos, {errors} erros          ")


def test_connection():
    print("🔌 Testando conexão com Supabase...")
    try:
        r = requests.get(
            f"{SUPABASE_URL}/rest/v1/professionals?limit=1",
            headers=HEADERS,
            timeout=10
        )
        if r.status_code == 200:
            print("  ✅ Conexão OK!")
            return True
        else:
            print(f"  ❌ Erro de conexão: HTTP {r.status_code}")
            print(f"     {r.text[:300]}")
            return False
    except Exception as e:
        print(f"  ❌ Não foi possível conectar: {e}")
        return False


def main():
    print(f"\n{'='*56}")
    print(f"  Importação Feegow → Supabase (SintesIA)")
    print(f"{'='*56}")

    if not test_connection():
        print("\n  Verifique a chave do Supabase e tente novamente.")
        return

    print(f"\n📁 Pasta dos CSVs: {CSV_DIR}")

    for table, csv_filename in IMPORT_ORDER:
        import_table(table, CSV_DIR / csv_filename)

    print(f"\n{'='*56}")
    print(f"  ✅ Importação concluída!")
    print(f"     Verifique no Supabase Dashboard → Table Editor")
    print(f"{'='*56}\n")


if __name__ == "__main__":
    main()
