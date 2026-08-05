import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL     = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_SERVICE = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    // Verifica se quem chama e ADMIN -- valida o JWT do usuario logado
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Nao autorizado' }), {
        status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Cria client com a chave do usuario para validar identidade
    const userClient = createClient(SUPABASE_URL, Deno.env.get('SUPABASE_ANON_KEY')!, {
      global: { headers: { Authorization: authHeader } },
    });

    const { data: { user }, error: authErr } = await userClient.auth.getUser();
    if (authErr || !user) {
      return new Response(JSON.stringify({ error: 'Sessao invalida' }), {
        status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Verifica se o usuario logado e ADMIN
    const adminClient = createClient(SUPABASE_URL, SUPABASE_SERVICE);
    const { data: profile } = await adminClient
      .from('profiles')
      .select('role')
      .eq('id', user.id)
      .single();

    if (!profile || profile.role !== 'ADMIN') {
      return new Response(JSON.stringify({ error: 'Apenas administradores podem convidar usuarios.' }), {
        status: 403, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Le o body
    const { email, role } = await req.json() as { email: string; role: string };
    if (!email || !role) {
      return new Response(JSON.stringify({ error: 'Email e papel sao obrigatorios.' }), {
        status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const validRoles = ['ADMIN', 'DOCTOR', 'RECEPTIONIST'];
    if (!validRoles.includes(role)) {
      return new Response(JSON.stringify({ error: 'Papel invalido.' }), {
        status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Envia convite (Supabase envia email automatico com link de acesso)
    const { data: inviteData, error: inviteErr } = await adminClient.auth.admin.inviteUserByEmail(email, {
      data: { role },
      redirectTo: Deno.env.get('INVITE_REDIRECT_URL') || 'https://agenda-health.vercel.app',
    });

    if (inviteErr) {
      // Usuario ja existe: ainda assim garante o role no profile
      if (inviteErr.message && inviteErr.message.includes('already been registered')) {
        const { data: existingUser } = await adminClient
          .from('profiles')
          .select('id')
          .eq('email', email)
          .single();

        if (existingUser) {
          await adminClient
            .from('profiles')
            .update({ role })
            .eq('id', existingUser.id);
        }
        return new Response(JSON.stringify({ ok: true, message: 'Usuario ja existe -- papel atualizado.' }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }
      throw inviteErr;
    }

    // Garante que o profile ja existe e tem o role correto
    if (inviteData && inviteData.user && inviteData.user.id) {
      await adminClient.from('profiles').upsert({
        id:    inviteData.user.id,
        email: email,
        role,
      }, { onConflict: 'id' });
    }

    return new Response(JSON.stringify({ ok: true, message: 'Convite enviado com sucesso!' }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (err) {
    const msg = (err instanceof Error) ? err.message : 'Erro interno';
    console.error('invite-user error:', msg);
    return new Response(JSON.stringify({ error: msg }), {
      status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
