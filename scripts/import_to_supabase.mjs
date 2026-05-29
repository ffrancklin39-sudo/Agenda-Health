/**
 * import_to_supabase.mjs — Importa dados Feegow → Supabase
 * Uso: node import_to_supabase.mjs
 */

import { readFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

const SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co";
const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODMwMjk1NCwiZXhwIjoyMDgzODc4OTU0fQ.cnD-3_9kfasLNi8W9WMlGmRIJj9JOH8H8wDqP-HFYCc";

const JSON_DIR   = join(__dirname, "migration_output");
const BATCH_SIZE = 300;

const HEADERS = {
  "apikey":        SUPABASE_KEY,
  "Authorization": `Bearer ${SUPABASE_KEY}`,
  "Content-Type":  "application/json",
  "Prefer":        "resolution=merge-duplicates,return=minimal", // upsert seguro
};

const IMPORT_ORDER = [
  { table: "professionals", file: "professionals.json" },
  { table: "services",      file: "services.json"      },
  { table: "patients",      file: "patients.json"      },
  { table: "appointments",  file: "appointments.json"  },
];

function sleep(ms) { return new Promise(r => setTimeout(r, ms)); }

function chunks(arr, size) {
  const out = [];
  for (let i = 0; i < arr.length; i += size) out.push(arr.slice(i, i + size));
  return out;
}

async function upsertBatch(table, rows) {
  const url = `${SUPABASE_URL}/rest/v1/${table}`;
  const res = await fetch(url, {
    method:  "POST",
    headers: HEADERS,
    body:    JSON.stringify(rows),
  });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`HTTP ${res.status}: ${body.slice(0, 250)}`);
  }
}

async function testConnection() {
  process.stdout.write("🔌 Testando conexão... ");
  const res = await fetch(`${SUPABASE_URL}/rest/v1/professionals?limit=1`, {
    headers: { "apikey": SUPABASE_KEY, "Authorization": `Bearer ${SUPABASE_KEY}` }
  });
  if (res.ok) { console.log("✅ OK!"); return true; }
  console.log(`❌ Falhou (HTTP ${res.status})`);
  return false;
}

async function importTable(table, jsonFile) {
  const path = join(JSON_DIR, jsonFile);
  console.log(`\n  📥 ${table}...`);

  let rows;
  try { rows = JSON.parse(readFileSync(path, "utf-8")); }
  catch (e) { console.log(`    ⚠️  Arquivo não encontrado: ${path}`); return; }

  const batches = chunks(rows, BATCH_SIZE);
  let done = 0, errors = 0;

  for (const batch of batches) {
    try {
      await upsertBatch(table, batch);
      done += batch.length;
    } catch (e) {
      errors += batch.length;
      console.log(`\n    ❌ Erro no lote: ${e.message}`);
    }
    process.stdout.write(`    ${Math.round(done / rows.length * 100)}% — ${done}/${rows.length}\r`);
    await sleep(100);
  }

  const status = errors === 0 ? "✅" : "⚠️ ";
  console.log(`    ${status} ${done} inseridos${errors ? `, ${errors} erros` : ""}            `);
}

async function main() {
  console.log("\n" + "=".repeat(52));
  console.log("  Importação Feegow → Supabase (SintesIA)");
  console.log("=".repeat(52));

  if (!await testConnection()) { process.exit(1); }

  for (const { table, file } of IMPORT_ORDER) {
    await importTable(table, file);
  }

  console.log("\n" + "=".repeat(52));
  console.log("  ✅ Pronto! Confira em supabase.com → Table Editor");
  console.log("=".repeat(52) + "\n");
}

main().catch(e => { console.error("Erro:", e); process.exit(1); });
