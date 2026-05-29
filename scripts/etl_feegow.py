#!/usr/bin/env python3
"""
Script de ETL (Extract-Transform-Load) para migração de dados Feegow → SintesIA
Suporta CSV, JSON e API do Feegow
"""

import csv
import json
import sys
from datetime import datetime
from typing import List, Dict, Optional
import requests
from pathlib import Path

# ============================================================================
# CONFIGURAÇÃO
# ============================================================================

FEEGOW_API_URL = "https://api.feegow.com.br/v1"  # Substitua pela URL real
FEEGOW_API_KEY = "seu_api_key_aqui"  # Substitua pela chave real

SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co"
SUPABASE_KEY = "seu_anon_key_aqui"  # Substitua

# Mapeamento de status Feegow → SintesIA
STATUS_MAP = {
    "novo": "lead",
    "em_andamento": "negotiation",
    "aguardando": "waiting",
    "agendado": "scheduled",
    "confirmado": "confirmed",
    "cancelado": "discarded",
}

# ============================================================================
# FUNÇÕES DE TRANSFORMAÇÃO
# ============================================================================

def transform_patient(feegow_record: Dict) -> Dict:
    """Transforma registro Feegow em formato SintesIA"""
    return {
        "id": feegow_record.get("id"),
        "name": feegow_record.get("nome", "Sem Nome"),
        "email": feegow_record.get("email", ""),
        "phone": feegow_record.get("telefone", ""),
        "cpf": feegow_record.get("cpf", ""),
        "status": STATUS_MAP.get(feegow_record.get("status", "novo"), "lead"),
        "appointment_date": feegow_record.get("data_agendamento"),
        "price": float(feegow_record.get("valor_consulta", 0)),
        "observation": feegow_record.get("observacoes", ""),
        "source": "Feegow",
        "created_at": feegow_record.get("data_criacao", datetime.now().isoformat()),
    }

def transform_appointment(feegow_record: Dict) -> Dict:
    """Transforma agendamento Feegow em formato SintesIA"""
    return {
        "id": feegow_record.get("id"),
        "patient_id": feegow_record.get("paciente_id"),
        "professional_id": feegow_record.get("profissional_id"),
        "service_id": feegow_record.get("servico_id"),
        "date_time": feegow_record.get("data_hora"),
        "duration_minutes": feegow_record.get("duracao", 60),
        "status": "scheduled" if feegow_record.get("status") == "agendado" else "completed",
        "notes": feegow_record.get("observacoes", ""),
    }

def transform_payment(feegow_record: Dict) -> Dict:
    """Transforma pagamento Feegow em formato SintesIA"""
    return {
        "id": feegow_record.get("id"),
        "patient_id": feegow_record.get("paciente_id"),
        "appointment_id": feegow_record.get("consulta_id"),
        "amount": float(feegow_record.get("valor", 0)),
        "status": "paid" if feegow_record.get("pago") else "pending",
        "payment_method": feegow_record.get("forma_pagamento", "cash"),
        "payment_date": feegow_record.get("data_pagamento"),
    }

# ============================================================================
# FUNÇÕES DE EXTRAÇÃO
# ============================================================================

def extract_from_csv(filepath: str, record_type: str = "patients") -> List[Dict]:
    """Extrai dados de arquivo CSV"""
    records = []
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                records.append(row)
        print(f"✅ Extraídos {len(records)} registros de {filepath}")
        return records
    except Exception as e:
        print(f"❌ Erro ao ler CSV: {e}")
        return []

def extract_from_feegow_api(endpoint: str, params: Optional[Dict] = None) -> List[Dict]:
    """Extrai dados diretamente da API Feegow"""
    try:
        headers = {
            "Authorization": f"Bearer {FEEGOW_API_KEY}",
            "Content-Type": "application/json"
        }
        url = f"{FEEGOW_API_URL}/{endpoint}"
        response = requests.get(url, headers=headers, params=params, timeout=30)
        response.raise_for_status()
        data = response.json()
        records = data.get("data", [])
        print(f"✅ Extraídos {len(records)} registros de {endpoint}")
        return records
    except requests.exceptions.RequestException as e:
        print(f"❌ Erro ao chamar API Feegow: {e}")
        return []

# ============================================================================
# FUNÇÕES DE CARGA
# ============================================================================

def load_to_supabase(records: List[Dict], table: str, batch_size: int = 100) -> bool:
    """Carrega registros no Supabase"""
    try:
        import supabase
        client = supabase.create_client(SUPABASE_URL, SUPABASE_KEY)

        # Processar em lotes para evitar timeout
        for i in range(0, len(records), batch_size):
            batch = records[i:i+batch_size]
            response = client.table(table).insert(batch).execute()
            print(f"✅ Carregados {len(batch)} registros na tabela '{table}'")

        return True
    except Exception as e:
        print(f"❌ Erro ao carregar dados no Supabase: {e}")
        return False

# ============================================================================
# FUNÇÕES DE VALIDAÇÃO
# ============================================================================

def validate_records(records: List[Dict], record_type: str) -> List[Dict]:
    """Valida e limpa registros antes de carregar"""
    valid = []
    errors = 0

    for record in records:
        try:
            # Validação básica
            if record_type == "patients":
                if not record.get("name"):
                    print(f"⚠️ Paciente sem nome: {record.get('id')}")
                    continue
                record = transform_patient(record)

            elif record_type == "appointments":
                if not record.get("date_time"):
                    print(f"⚠️ Agendamento sem data: {record.get('id')}")
                    continue
                record = transform_appointment(record)

            elif record_type == "payments":
                if not record.get("amount"):
                    print(f"⚠️ Pagamento sem valor: {record.get('id')}")
                    continue
                record = transform_payment(record)

            valid.append(record)
        except Exception as e:
            print(f"❌ Erro ao validar registro {record.get('id')}: {e}")
            errors += 1

    print(f"✅ Validados {len(valid)} / {len(records)} registros ({errors} erros)")
    return valid

# ============================================================================
# FUNÇÃO PRINCIPAL
# ============================================================================

def migrate(
    source_type: str = "csv",
    source: str = "pacientes.csv",
    record_type: str = "patients",
    dry_run: bool = True
) -> bool:
    """
    Executa migração completa

    Args:
        source_type: 'csv' ou 'api'
        source: caminho do CSV ou endpoint da API
        record_type: 'patients', 'appointments', ou 'payments'
        dry_run: se True, apenas valida sem carregar
    """

    print(f"\n{'='*60}")
    print(f"🚀 Migrando {record_type} de {source} (Feegow → SintesIA)")
    print(f"{'='*60}\n")

    # EXTRACT
    print("📥 Extraindo dados...")
    if source_type == "csv":
        records = extract_from_csv(source, record_type)
    elif source_type == "api":
        records = extract_from_feegow_api(source)
    else:
        print(f"❌ Tipo de fonte inválida: {source_type}")
        return False

    if not records:
        print("❌ Nenhum registro extraído!")
        return False

    # TRANSFORM
    print(f"\n🔄 Validando {len(records)} registros...")
    records = validate_records(records, record_type)

    if not records:
        print("❌ Nenhum registro válido!")
        return False

    # LOAD
    print(f"\n💾 Carregando no Supabase...")
    if dry_run:
        print(f"⚠️ DRY RUN: Não carregando dados (remove --dry-run para confirmar)")
        print(f"Primeiros 2 registros a serem carregados:")
        for record in records[:2]:
            print(json.dumps(record, indent=2, default=str))
        return True

    return load_to_supabase(records, record_type)

# ============================================================================
# SCRIPT
# ============================================================================

if __name__ == "__main__":
    # Exemplo de uso:
    # python etl_feegow.py --source pacientes.csv --type patients --dry-run
    # python etl_feegow.py --source pacientes.csv --type patients  # Carrega de verdade

    import argparse

    parser = argparse.ArgumentParser(
        description="Script de ETL para migração Feegow → SintesIA"
    )
    parser.add_argument("--source", default="pacientes.csv", help="Arquivo CSV ou endpoint API")
    parser.add_argument("--type", choices=["patients", "appointments", "payments"],
                       default="patients", help="Tipo de dado a migrar")
    parser.add_argument("--source-type", choices=["csv", "api"], default="csv",
                       help="Tipo de fonte")
    parser.add_argument("--dry-run", action="store_true", default=True,
                       help="Apenas valida sem carregar (padrão)")
    parser.add_argument("--confirm", action="store_true",
                       help="Confirma carregamento real (remove --dry-run)")

    args = parser.parse_args()

    # Confirmar se não é dry-run
    dry_run = not args.confirm

    success = migrate(
        source_type=args.source_type,
        source=args.source,
        record_type=args.type,
        dry_run=dry_run
    )

    sys.exit(0 if success else 1)
