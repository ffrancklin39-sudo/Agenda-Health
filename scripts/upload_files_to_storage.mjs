/**
 * upload_files_to_storage.mjs
 * Faz upload dos 910 arquivos (PDFs e imagens) para o Supabase Storage
 * e marca cada um como uploaded na tabela patient_files.
 *
 * Pré-requisito: rodar import_clinical_records.mjs antes (cria os registros na tabela)
 * Uso: node upload_files_to_storage.mjs
 *
 * ⚠️  Atenção: o upload leva ~30-60 minutos dependendo da internet (953 MB).
 *     Pode interromper e rodar novamente — ele pula arquivos já enviados.
 */
import { readFileSync, existsSync, statSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));

const SUPABASE_URL = "https://iudghjdmfcxjcpspeify.supabase.co";
const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODMwMjk1NCwiZXhwIjoyMDgzODc4OTU0fQ.cnD-3_9kfasLNi8W9WMlGmRIJj9JOH8H8wDqP-HFYCc";
const BUCKET = "patient-files";

const MIME_MAP = {
  pdf: "application/pdf", jpg: "image/jpeg", jpeg: "image/jpeg",
  png: "image/png", webp: "image/webp", gif: "image/gif",
};

const BASE_PATH = "C:\\Fellipe Francklin\\Candia\\d457fd08-5b27-41bd-b089-c974a170f56c-backup feegow\\Client";

const sleep = ms => new Promise(r => setTimeout(r, ms));

async function uploadFile(storagePath, localPath, mimeType) {
  const fileData = readFileSync(localPath);
  const res = await fetch(`${SUPABASE_URL}/storage/v1/object/${BUCKET}/${storagePath}`, {
    method: "POST",
    headers: {
      "apikey": SUPABASE_KEY,
      "Authorization": `Bearer ${SUPABASE_KEY}`,
      "Content-Type": mimeType,
      "x-upsert": "true",  // sobrescreve se já existe
    },
    body: fileData,
  });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`HTTP ${res.status}: ${body.slice(0,150)}`);
  }
}

async function markUploaded(recordId, storagePath) {
  await fetch(`${SUPABASE_URL}/rest/v1/patient_files?id=eq.${recordId}`, {
    method: "PATCH",
    headers: {
      "apikey": SUPABASE_KEY, "Authorization": `Bearer ${SUPABASE_KEY}`,
      "Content-Type": "application/json", "Prefer": "return=minimal",
    },
    body: JSON.stringify({ uploaded: true, storage_path: storagePath }),
  });
}

async function ensureBucket() {
  // Cria o bucket se não existir
  const res = await fetch(`${SUPABASE_URL}/storage/v1/bucket`, {
    method: "POST",
    headers: {
      "apikey": SUPABASE_KEY,
      "Authorization": `Bearer ${SUPABASE_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ id: BUCKET, name: BUCKET, public: false }),
  });
  if (res.ok) {
    console.log(`  ✅ Bucket '${BUCKET}' criado.`);
  } else {
    const body = await res.json();
    if (body?.error === "Duplicate" || body?.message?.includes("already exists")) {
      console.log(`  ℹ️  Bucket '${BUCKET}' já existe.`);
    } else {
      throw new Error(`Falha ao criar bucket: ${JSON.stringify(body)}`);
    }
  }
}

async function fetchAlreadyUploaded() {
  // Busca IDs já marcados como uploaded=true no banco (paginado)
  const uploaded = new Set();
  let offset = 0;
  while (true) {
    const res = await fetch(
      `${SUPABASE_URL}/rest/v1/patient_files?uploaded=eq.true&select=id&limit=1000&offset=${offset}`,
      { headers: { "apikey": SUPABASE_KEY, "Authorization": `Bearer ${SUPABASE_KEY}` } }
    );
    const rows = await res.json();
    if (!Array.isArray(rows) || rows.length === 0) break;
    rows.forEach(r => uploaded.add(r.id));
    if (rows.length < 1000) break;
    offset += 1000;
  }
  return uploaded;
}

async function main() {
  const metaFile = join(__dirname, "migration_output", "patient_files_meta.json");
  const allFiles = JSON.parse(readFileSync(metaFile, "utf-8"));

  console.log("\n" + "=".repeat(60));
  console.log("  Upload de Arquivos → Supabase Storage");
  console.log(`  Total: ${allFiles.length} arquivos`);
  console.log("=".repeat(60) + "\n");

  await ensureBucket();

  // Verifica o que já foi enviado para não repetir
  process.stdout.write("  🔍 Verificando arquivos já enviados...");
  const alreadyUploaded = await fetchAlreadyUploaded();
  console.log(` ${alreadyUploaded.size} já concluídos, ${allFiles.length - alreadyUploaded.size} restantes.\n`);

  let done = 0, skipped = 0, already = 0, errors = 0;
  const totalMB = allFiles.reduce((s, f) => s + (f.file_size || 0), 0) / 1024 / 1024;

  for (const file of allFiles) {
    // Pula arquivos já enviados
    if (alreadyUploaded.has(file.id)) {
      already++;
      continue;
    }

    const localPath = join(BASE_PATH, file.folder, file._original_name || file.file_name);

    if (!existsSync(localPath)) {
      skipped++;
      continue;
    }

    // Caminho no Storage: patients/{patient_id}/{folder}/{filename}
    const storagePath = `patients/${file.patient_id}/${file.folder}/${file._original_name || file.file_name}`;
    const ext = (file.file_type || "").toLowerCase();
    const mime = MIME_MAP[ext] || "application/octet-stream";

    try {
      await uploadFile(storagePath, localPath, mime);
      await markUploaded(file.id, storagePath);
      done++;
    } catch (e) {
      errors++;
      if (errors <= 5) console.log(`\n  ❌ ${file.file_name}: ${e.message}`);
    }

    const pct = Math.round((done + skipped + errors) / allFiles.length * 100);
    process.stdout.write(`  ${pct}% — ✅${done} ✔️já:${already} ⏭️${skipped} ❌${errors} / ${allFiles.length}\r`);
    await sleep(50);
  }

  console.log(`\n\n${"=".repeat(60)}`);
  console.log(`  ✅ ${done} enviados agora  ✔️ ${already} já estavam prontos  ⏭️ ${skipped} não encontrados  ❌ ${errors} erros`);
  console.log(`  Total enviado: ~${(done / allFiles.length * totalMB).toFixed(0)} MB`);
  console.log("=".repeat(60) + "\n");
}

main().catch(console.error);
