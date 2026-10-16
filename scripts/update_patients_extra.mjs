/**
 * update_patients_extra.mjs
 * Atualiza birth_date, gender e endereço dos pacientes já importados.
 * Uso: node update_patients_extra.mjs
 */
import { readFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY; // nunca commitar a chave
if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Defina SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY no ambiente.");
  process.exit(1);
}

const HEADERS = {
  "apikey": SUPABASE_KEY,
  "Authorization": `Bearer ${SUPABASE_KEY}`,
  "Content-Type": "application/json",
  "Prefer": "resolution=merge-duplicates,return=minimal",
};

function sleep(ms) { return new Promise(r => setTimeout(r, ms)); }
function chunks(arr, n) { const out=[]; for(let i=0;i<arr.length;i+=n) out.push(arr.slice(i,i+n)); return out; }

async function main() {
  const data = JSON.parse(readFileSync(join(__dirname, "migration_output/patients_extra.json"), "utf-8"));
  console.log(`\nAtualizando ${data.length} pacientes com birth_date, gender e endereço...\n`);

  let done = 0, errors = 0;
  for (const batch of chunks(data, 300)) {
    const res = await fetch(`${SUPABASE_URL}/rest/v1/patients`, {
      method: "POST", headers: HEADERS, body: JSON.stringify(batch),
    });
    if (res.ok) { done += batch.length; }
    else { errors += batch.length; console.log(`  ❌ ${await res.text()}`); }
    process.stdout.write(`  ${Math.round(done/data.length*100)}% — ${done}/${data.length}\r`);
    await sleep(100);
  }
  console.log(`\n  ✅ ${done} atualizados${errors ? `, ${errors} erros` : ""}\n`);
}
main().catch(console.error);
