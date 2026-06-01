import React, { useState } from 'react';
import { supabase } from '../services/supabaseClient';
import { Loader2, Lock, CheckCircle, Eye, EyeOff } from 'lucide-react';

const LOGO_LOGIN = 'https://iudghjdmfcxjcpspeify.supabase.co/storage/v1/object/public/Public%20SintesIA/SintesIA%20-%20logo-oficial.webp';

interface Props {
  onDone: () => void;
}

const PasswordReset: React.FC<Props> = ({ onDone }) => {
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [showPass, setShowPass] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [done, setDone] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (password.length < 6) {
      setError('A senha deve ter pelo menos 6 caracteres.');
      return;
    }
    if (password !== confirm) {
      setError('As senhas não coincidem.');
      return;
    }

    setLoading(true);
    const { error } = await supabase.auth.updateUser({ password });
    setLoading(false);

    if (error) {
      setError('Erro ao redefinir senha. Tente novamente.');
    } else {
      setDone(true);
      setTimeout(() => onDone(), 2500);
    }
  };

  return (
    <div className="min-h-screen bg-white flex items-center justify-center p-8">
      <div className="w-full max-w-sm">

        {/* Logo */}
        <div className="mb-10 flex justify-center">
          <img
            src={LOGO_LOGIN}
            alt="SintesIA"
            className="h-36 object-contain"
            style={{ mixBlendMode: 'multiply' }}
            onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }}
          />
        </div>

        {!done ? (
          <>
            <div className="mb-8">
              <h2 className="text-2xl font-bold text-slate-800 mb-1">Criar nova senha</h2>
              <p className="text-slate-500 text-sm">Escolha uma senha segura para sua conta.</p>
            </div>

            {error && (
              <div className="bg-rose-50 border border-rose-200 text-rose-700 px-4 py-3 rounded-xl mb-5 text-sm font-medium">
                {error}
              </div>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">
                  Nova senha
                </label>
                <div className="relative">
                  <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <input
                    type={showPass ? 'text' : 'password'}
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    className="w-full pl-10 pr-10 py-3 bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-slate-900 text-sm shadow-sm"
                    placeholder="Mínimo 6 caracteres"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPass(!showPass)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
                  >
                    {showPass ? <EyeOff size={16} /> : <Eye size={16} />}
                  </button>
                </div>
              </div>

              <div>
                <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">
                  Confirmar senha
                </label>
                <div className="relative">
                  <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <input
                    type={showPass ? 'text' : 'password'}
                    required
                    value={confirm}
                    onChange={(e) => setConfirm(e.target.value)}
                    className="w-full pl-10 pr-4 py-3 bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-slate-900 text-sm shadow-sm"
                    placeholder="Repita a nova senha"
                  />
                </div>
              </div>

              {/* Indicador de força */}
              {password.length > 0 && (
                <div className="space-y-1">
                  <div className="flex gap-1">
                    {[...Array(4)].map((_, i) => (
                      <div
                        key={i}
                        className={`h-1 flex-1 rounded-full transition-colors ${
                          password.length >= (i + 1) * 3
                            ? password.length >= 12 ? 'bg-emerald-500' : password.length >= 8 ? 'bg-yellow-400' : 'bg-rose-400'
                            : 'bg-slate-200'
                        }`}
                      />
                    ))}
                  </div>
                  <p className="text-xs text-slate-400">
                    {password.length < 6 ? 'Muito curta' : password.length < 8 ? 'Fraca' : password.length < 12 ? 'Boa' : 'Forte'}
                  </p>
                </div>
              )}

              <div className="pt-2">
                <button
                  type="submit"
                  disabled={loading}
                  className="w-full py-3.5 px-4 bg-gradient-to-r from-indigo-600 to-cyan-600 hover:from-indigo-700 hover:to-cyan-700 text-white font-bold rounded-xl flex items-center justify-center gap-2 transition-all shadow-md disabled:opacity-70 text-sm"
                >
                  {loading ? <Loader2 className="animate-spin" size={18} /> : <Lock size={18} />}
                  <span>{loading ? 'Salvando...' : 'Salvar nova senha'}</span>
                </button>
              </div>
            </form>
          </>
        ) : (
          <div className="flex flex-col items-center text-center py-4">
            <div className="w-16 h-16 bg-emerald-50 rounded-full flex items-center justify-center mb-4">
              <CheckCircle className="text-emerald-500" size={32} />
            </div>
            <h2 className="text-xl font-bold text-slate-800 mb-2">Senha redefinida!</h2>
            <p className="text-slate-500 text-sm">Entrando no sistema...</p>
          </div>
        )}

        <p className="text-center text-xs text-slate-400 mt-8">
          SintesIA © {new Date().getFullYear()} · Todos os direitos reservados
        </p>
      </div>
    </div>
  );
};

export default PasswordReset;
