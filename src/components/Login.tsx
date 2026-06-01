import React, { useState, useEffect } from 'react';
import { supabase } from '../services/supabaseClient';
import { Loader2, LogIn, Mail, Lock, ArrowLeft, CheckCircle } from 'lucide-react';

const LOGO_LOGIN = 'https://iudghjdmfcxjcpspeify.supabase.co/storage/v1/object/public/Public%20SintesIA/SintesIA%20-%20logo-oficial.webp';
const LOGO_IMAGE = 'https://iudghjdmfcxjcpspeify.supabase.co/storage/v1/object/public/Public%20SintesIA/SintesIA-Hz-sidebar.png';

// Imagem Unsplash: médica analisando dados digitais em tablet — saúde + tecnologia
const BG_IMAGE = 'https://iudghjdmfcxjcpspeify.supabase.co/storage/v1/object/public/Public%20SintesIA/Capa-sintesia.webp';

const Login: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [saudacao, setSaudacao] = useState('Olá');
  const [mensagem, setMensagem] = useState('');
  const [mode, setMode] = useState<'login' | 'reset' | 'reset-sent'>('login');
  const [resetEmail, setResetEmail] = useState('');
  const [resetLoading, setResetLoading] = useState(false);

  useEffect(() => {
    const hora = new Date().getHours();
    if (hora >= 5 && hora < 12) {
      setSaudacao('Bom dia');
      setMensagem('Que sua manhã seja repleta de cuidado e propósito.');
    } else if (hora >= 12 && hora < 18) {
      setSaudacao('Boa tarde');
      setMensagem('Cada atendimento de hoje transforma uma vida.');
    } else {
      setSaudacao('Boa noite');
      setMensagem('A saúde não para. Obrigado por estar aqui.');
    }
  }, []);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) {
      setError('E-mail ou senha incorretos. Tente novamente.');
      setLoading(false);
    }
  };

  const handleReset = async (e: React.FormEvent) => {
    e.preventDefault();
    setResetLoading(true);
    await supabase.auth.resetPasswordForEmail(resetEmail, {
      redirectTo: `${window.location.origin}/reset-password`,
    });
    setResetLoading(false);
    setMode('reset-sent');
  };

  return (
    <div className="min-h-screen flex flex-row-reverse">

      {/* ─── LADO DIREITO (maior) — Visual / Imagem ─── */}
      <div
        className="hidden lg:flex lg:w-[70%] relative overflow-hidden flex-col items-center justify-end pb-16 px-12"
        style={{
          backgroundImage: `url(${BG_IMAGE})`,
          backgroundSize: 'cover',
          backgroundPosition: 'center',
        }}
      >
        {/* Overlay gradiente sobre a foto */}
        <div className="absolute inset-0" style={{ background: 'linear-gradient(to top, #0f0e2e 0%, rgba(15,14,46,0.80) 40%, rgba(15,14,46,0.2) 70%, transparent 100%)' }} />
        <div className="absolute inset-0" style={{ background: 'linear-gradient(to right, rgba(15,14,46,0.4) 0%, transparent 60%)' }} />

        {/* Conteúdo sobre a imagem */}
        <div className="relative z-10 text-center max-w-lg">


          {/* Saudação */}
          <p className="text-cyan-300 text-sm font-semibold tracking-widest uppercase mb-3">
            {saudacao}, Clínica Candia
          </p>

          {/* Headline */}
          <h2 className="text-white text-4xl font-bold leading-tight mb-4 drop-shadow-lg">
            Onde dados se tornam<br />
            <span className="text-cyan-300">cuidado de verdade.</span>
          </h2>

          {/* Mensagem motivacional */}
          <p className="text-indigo-200 text-base leading-relaxed mb-8">
            "{mensagem}"
          </p>

          {/* Tags */}
          <div className="flex gap-2 justify-center flex-wrap">
            {['Pacientes', 'Agenda', 'Prontuários', 'Inteligência Clínica'].map(tag => (
              <span
                key={tag}
                className="px-3 py-1 bg-white/10 backdrop-blur-sm border border-white/20 text-white/80 text-xs rounded-full"
              >
                {tag}
              </span>
            ))}
          </div>
        </div>

        {/* Rodapé da imagem */}
        <div className="absolute bottom-4 left-0 right-0 text-center">
          <p className="text-indigo-400/60 text-xs">SintesIA — Ecossistema Clínico Inteligente</p>
        </div>
      </div>

      {/* ─── LADO ESQUERDO (menor) — Login ─── */}
      <div className="w-full lg:w-[30%] flex items-center justify-center bg-white p-8">
        <div className="w-full max-w-sm">

          {/* Logo oficial no lado do login — centralizada e maior */}
          <div className="mb-10 flex justify-center">
            <img
              src={LOGO_LOGIN}
              alt="SintesIA"
              className="h-44 object-contain"
              style={{ mixBlendMode: 'multiply' }}
              onError={(e) => {
                const el = e.target as HTMLImageElement;
                el.style.display = 'none';
                const fallback = el.nextElementSibling as HTMLElement;
                if (fallback) fallback.style.display = 'flex';
              }}
            />
            {/* Fallback caso a logo não carregue */}
            <div className="items-center gap-3 hidden">
              <div className="w-14 h-14 bg-gradient-to-br from-indigo-600 to-cyan-500 rounded-xl flex items-center justify-center shadow-lg">
                <span className="text-white text-2xl font-black">S</span>
              </div>
            </div>
          </div>

          {/* Título */}
          <div className="mb-8">
            <h2 className="text-2xl font-bold text-slate-800 mb-1">
              {mode === 'login' ? 'Acesse sua conta' : mode === 'reset' ? 'Redefinir senha' : 'E-mail enviado!'}
            </h2>
            <p className="text-slate-500 text-sm">
              {mode === 'login' ? 'Entre com suas credenciais para continuar.' : mode === 'reset' ? 'Informe seu e-mail para receber o link de redefinição.' : 'Verifique sua caixa de entrada.'}
            </p>
          </div>

          {/* Erro */}
          {error && mode === 'login' && (
            <div className="bg-rose-50 border border-rose-200 text-rose-700 px-4 py-3 rounded-xl mb-5 text-sm font-medium">
              {error}
            </div>
          )}

          {/* ── TELA: LOGIN ── */}
          {mode === 'login' && (
            <form onSubmit={handleLogin} className="space-y-4">
              <div>
                <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">E-mail</label>
                <div className="relative">
                  <Mail className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <input
                    type="email"
                    required
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className="w-full pl-10 pr-4 py-3 bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-slate-900 text-sm shadow-sm"
                    placeholder="seu@email.com"
                  />
                </div>
              </div>

              <div>
                <div className="flex items-center justify-between mb-2">
                  <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider">Senha</label>
                  <button
                    type="button"
                    onClick={() => { setMode('reset'); setResetEmail(email); setError(null); }}
                    className="text-xs text-indigo-600 hover:text-indigo-800 font-medium transition-colors"
                  >
                    Esqueci minha senha
                  </button>
                </div>
                <div className="relative">
                  <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <input
                    type="password"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    className="w-full pl-10 pr-4 py-3 bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-slate-900 text-sm shadow-sm"
                    placeholder="••••••••"
                  />
                </div>
              </div>

              <div className="pt-2">
                <button
                  type="submit"
                  disabled={loading}
                  className="w-full py-3.5 px-4 bg-gradient-to-r from-indigo-600 to-cyan-600 hover:from-indigo-700 hover:to-cyan-700 text-white font-bold rounded-xl flex items-center justify-center gap-2 transition-all shadow-md hover:shadow-lg disabled:opacity-70 text-sm"
                >
                  {loading ? <Loader2 className="animate-spin" size={18} /> : <LogIn size={18} />}
                  <span>{loading ? 'Entrando...' : 'Entrar no Sistema'}</span>
                </button>
              </div>
            </form>
          )}

          {/* ── TELA: RESET ── */}
          {mode === 'reset' && (
            <form onSubmit={handleReset} className="space-y-4">
              <div>
                <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">E-mail</label>
                <div className="relative">
                  <Mail className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <input
                    type="email"
                    required
                    value={resetEmail}
                    onChange={(e) => setResetEmail(e.target.value)}
                    className="w-full pl-10 pr-4 py-3 bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-slate-900 text-sm shadow-sm"
                    placeholder="seu@email.com"
                  />
                </div>
              </div>
              <div className="pt-2 space-y-3">
                <button
                  type="submit"
                  disabled={resetLoading}
                  className="w-full py-3.5 px-4 bg-gradient-to-r from-indigo-600 to-cyan-600 hover:from-indigo-700 hover:to-cyan-700 text-white font-bold rounded-xl flex items-center justify-center gap-2 transition-all shadow-md disabled:opacity-70 text-sm"
                >
                  {resetLoading ? <Loader2 className="animate-spin" size={18} /> : <Mail size={18} />}
                  <span>{resetLoading ? 'Enviando...' : 'Enviar link de redefinição'}</span>
                </button>
                <button
                  type="button"
                  onClick={() => setMode('login')}
                  className="w-full py-3 px-4 text-slate-500 hover:text-slate-700 font-medium rounded-xl flex items-center justify-center gap-2 text-sm transition-colors"
                >
                  <ArrowLeft size={16} />
                  <span>Voltar ao login</span>
                </button>
              </div>
            </form>
          )}

          {/* ── TELA: SUCESSO ── */}
          {mode === 'reset-sent' && (
            <div className="space-y-4">
              <div className="flex flex-col items-center py-4 text-center">
                <div className="w-16 h-16 bg-emerald-50 rounded-full flex items-center justify-center mb-4">
                  <CheckCircle className="text-emerald-500" size={32} />
                </div>
                <p className="text-slate-600 text-sm leading-relaxed">
                  Enviamos um link para <strong>{resetEmail}</strong>.<br />
                  Verifique sua caixa de entrada e spam.
                </p>
              </div>
              <button
                onClick={() => setMode('login')}
                className="w-full py-3 px-4 text-slate-500 hover:text-slate-700 font-medium rounded-xl flex items-center justify-center gap-2 text-sm border border-slate-200 hover:bg-slate-50 transition-colors"
              >
                <ArrowLeft size={16} />
                <span>Voltar ao login</span>
              </button>
            </div>
          )}

          {/* Bloco mobile — saudação */}
          <div className="lg:hidden mt-8 p-4 bg-indigo-50 rounded-xl border border-indigo-100">
            <p className="text-indigo-700 text-sm font-medium text-center">
              {saudacao}, Clínica Candia
            </p>
            <p className="text-indigo-500 text-xs text-center mt-1">"{mensagem}"</p>
          </div>

          <p className="text-center text-xs text-slate-400 mt-8">
            SintesIA © {new Date().getFullYear()} · Todos os direitos reservados
          </p>
        </div>
      </div>

    </div>
  );
};

export default Login;
