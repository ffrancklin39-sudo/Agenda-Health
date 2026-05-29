/**
 * import_clinical_records.mjs
 * Importa prescrições, atestados e pedidos de exame para o Supabase.
 * Uso: node import_clinical_records.mjs
 */
import { readFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));

const SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co";
const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODMwMjk1NCwiZXhwIjoyMDgzODc4OTU0fQ.cnD-3_9kfasLNi8W9WMlGmRIJj9JOH8H8wDqP-HFYCc";
const HEADERS = {
  "apikey": SUPABASE_KEY, "Authorization": `Bearer ${SUPABASE_KEY}`,
  "Content-Type": "application/json", "Prefer": "resolution=merge-duplicates,return=minimal",
};
const sleep = ms => new Promise(r => setTimeout(r, ms));
const chunks = (arr, n) => { const o=[]; for(let i=0;i<arr.length;i+=n) o.push(arr.slice(i,i+n)); return o; };

async function importTable(table, file, fields) {
  const allData = JSON.parse(readFileSync(join(__dirname, "migration_output", file), "utf-8"));
  // Remove campos privados que começam com _
  const data = allData.map(r => Object.fromEntries(Object.entries(r).filter(([k]) => !k.startsWith('_'))));
  console.log(`\n  📥 ${table} (${data.length} registros)...`);
  let done = 0, errors = 0;
  for (const batch of chunks(data, 200)) {
    const res = await fetch(`${SUPABASE_URL}/rest/v1/${table}`, {
      method: "POST", headers: HEADERS, body: JSON.stringify(batch)
    });
    if (res.ok) { done += batch.length; }
    else { errors += batch.length; console.log(`\n    ❌ ${(await res.text()).slice(0,200)}`); }
    process.stdout.write(`    ${Math.round(done/data.length*100)}% — ${done}/${data.length}\r`);
    await sleep(100);
  }
  console.log(`    ✅ ${done} inseridos${errors ? `, ${errors} erros` : ""}            `);
}

async function main() {
  console.log("\n" + "=".repeat(52));
  console.log("  Importando Prontuários → Supabase");
  console.log("=".repeat(52));
  await importTable("clinical_records", "clinical_records.json");
  await importTable("patient_files",    "patient_files_meta.json");
  console.log("\n  ✅ Metadados importados!");
  console.log("  ⚠️  Execute upload_files_to_storage.mjs para enviar os PDFs/imagens.\n");
}
main().catch(console.error);
