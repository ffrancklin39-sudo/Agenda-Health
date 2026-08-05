import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL     = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_SERVICE = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const SUPABASE_ANON    = Deno.env.get('SUPABASE_ANON_KEY')!;

const cors = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { ...cors, 'Content-Type': 'application/json' } });

serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: cors });

  try {
    // Valida JWT do usuario que chamou
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) return json({ error: 'Nao autorizado' }, 401);

    const userClient = createClient(SUPABASE_URL, SUPABASE_ANON, {
      global: { headers: { Authorization: authHeader } },
    });
    const { data: { user }, error: authErr } = await userClient.auth.getUser();
    if (authErr || !user) return json({ error: 'Sessao invalida' }, 401);

    // Verifica se e ADMIN
    const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE);
    const { data: profile } = await admin.from('profiles').select('role').eq('id', user.id).single();
    if (!profile || profile.role !== 'ADMIN') return json({ error: 'Apenas administradores podem convidar usuarios.' }, 403);

    // Le o body
    const body = await req.json().catch(() => ({}));
    const { email, role } = body as { email?: string; role?: string };
    if (!email || !role) return json({ error: 'Email e papel sao obrigatorios.' }, 400);
    if (!['ADMIN', 'DOCTOR', 'RECEPTIONIST'].includes(role)) return json({ error: 'Papel invalido.' }, 400);

    // Envia convite — sem redirectTo, usa o Site URL configurado no Supabase dashboard
    const { data: inviteData, error: inviteErr } = await admin.auth.admin.inviteUserByEmail(email, {
      data: { role },
    });

    if (inviteErr) {
      const msg = inviteErr.message || '';
      // Usuario ja existe/ja foi convidado — so atualiza o papel
      if (msg.includes('already') || msg.includes('registered') || msg.includes('existe')) {
        const { data: existing } = await admin.from('profiles').select('id').eq('email', email).single();
        if (existing) await admin.from('profiles').update({ role }).eq('id', existing.id);
        return json({ ok: true, message: 'Usuario ja existe — papel atualizado com sucesso.' });
      }
      console.error('inviteUserByEmail error:', msg);
      return json({ error: msg }, 400);
    }

    // Upsert do profile com o role correto
    if (inviteData?.user?.id) {
      await admin.from('profiles').upsert({ id: inviteData.user.id, email, role }, { onConflict: 'id' });
    }

    return json({ ok: true, message: 'Convite enviado com sucesso!' });

  } catch (err) {
    const msg = err instanceof Error ? err.message : 'Erro interno';
    console.error('invite-user crash:', msg);
    return json({ error: msg }, 500);
  }
});
