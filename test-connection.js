#!/usr/bin/env node
/**
 * Script para testar conexão com Supabase
 * node test-connection.js
 */

const SUPABASE_URL = 'https://iudghjdmfcxjcpspeify.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDI5NTQsImV4cCI6MjA4Mzg3ODk1NH0.f2rcdjPuxyx2REEviDRObE-Sn1D4ytb4_HwTDjW8Xao';

async function testConnection() {
  try {
    console.log('🔍 Testando conexão com Supabase...\n');

    // Teste 1: Verificar URL
    console.log(`✅ URL: ${SUPABASE_URL}`);

    // Teste 2: Verificar token (básico)
    const tokenParts = SUPABASE_KEY.split('.');
    if (tokenParts.length === 3) {
      console.log(`✅ Token JWT válido (3 partes detectadas)`);
    }

    // Teste 3: Fazer requisição GET simples
    const response = await fetch(
      `${SUPABASE_URL}/rest/v1/patients?limit=1`,
      {
        headers: {
          'Authorization': `Bearer ${SUPABASE_KEY}`,
          'Content-Type': 'application/json',
        },
      }
    );

    console.log(`\n📊 Status da resposta: ${response.status} ${response.statusText}`);

    if (response.ok) {
      const data = await response.json();
      console.log(`✅ Conexão bem-sucedida!`);
      console.log(`📈 Registros encontrados: ${data.length}`);
      if (data.length > 0) {
        console.log(`\n📝 Primeira entrada:`);
        console.log(JSON.stringify(data[0], null, 2));
      }
    } else if (response.status === 401) {
      console.log(`❌ Erro 401: Token inválido ou expirado`);
    } else if (response.status === 404) {
      console.log(`⚠️ Erro 404: Tabela 'patients' não encontrada`);
      console.log(`   Sugestão: Verifique se a tabela foi criada no Supabase`);
    } else {
      const error = await response.text();
      console.log(`❌ Erro ${response.status}:`);
      console.log(error);
    }

    // Teste 4: Listar todas as tabelas (se possível)
    console.log(`\n\n🔎 Tentando listar tabelas disponíveis...`);
    const tablesResponse = await fetch(
      `${SUPABASE_URL}/rest/v1/`,
      {
        headers: {
          'Authorization': `Bearer ${SUPABASE_KEY}`,
        },
      }
    );

    if (tablesResponse.ok) {
      const tables = await tablesResponse.json();
      console.log(`✅ Tabelas disponíveis:`);
      tables.forEach(t => console.log(`   - ${t.name}`));
    }

  } catch (error) {
    console.error('❌ Erro ao testar conexão:', error.message);
    process.exit(1);
  }
}

testConnection();
