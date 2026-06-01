import React, { useRef, useState } from 'react';
import { Camera, Loader2, X } from 'lucide-react';
import { supabase } from '../services/supabaseClient';

interface Props {
  currentUrl?: string | null;
  name: string;           // para gerar as iniciais de fallback
  color?: string;         // cor do anel/fundo
  size?: 'sm' | 'md' | 'lg';
  bucket?: string;        // default: 'profiles'
  folder?: string;        // ex: 'professionals' | 'patients'
  onUpload: (url: string) => void;
}

const SIZE = { sm: 'w-12 h-12 text-sm', md: 'w-20 h-20 text-xl', lg: 'w-28 h-28 text-3xl' };

const initials = (name: string) =>
  name.trim().split(/\s+/).slice(0, 2).map(w => w[0]?.toUpperCase() ?? '').join('');

const AvatarUpload: React.FC<Props> = ({
  currentUrl, name, color = '#6366f1', size = 'md',
  bucket = 'profiles', folder = 'general', onUpload,
}) => {
  const inputRef = useRef<HTMLInputElement>(null);
  const [uploading, setUploading] = useState(false);
  const [preview, setPreview] = useState<string | null>(currentUrl || null);
  const [error, setError] = useState<string | null>(null);

  const handleFile = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    if (!file.type.startsWith('image/')) { setError('Selecione uma imagem.'); return; }
    if (file.size > 5 * 1024 * 1024) { setError('Imagem deve ter menos de 5MB.'); return; }

    setError(null);
    setUploading(true);

    // preview local imediato
    const localUrl = URL.createObjectURL(file);
    setPreview(localUrl);

    const ext = file.name.split('.').pop();
    const path = `${folder}/${Date.now()}.${ext}`;

    const { error: upErr } = await supabase.storage.from(bucket).upload(path, file, { upsert: true });
    if (upErr) { setError('Erro ao fazer upload.'); setUploading(false); return; }

    const { data } = supabase.storage.from(bucket).getPublicUrl(path);
    setPreview(data.publicUrl);
    onUpload(data.publicUrl);
    setUploading(false);
  };

  return (
    <div className="flex flex-col items-center gap-2">
      <div className="relative group cursor-pointer" onClick={() => !uploading && inputRef.current?.click()}>
        {/* Avatar */}
        <div
          className={`${SIZE[size]} rounded-full overflow-hidden flex items-center justify-center font-bold text-white ring-2 ring-offset-2 transition-all group-hover:ring-4`}
          style={{ background: color, ringColor: color }}
        >
          {preview
            ? <img src={preview} alt={name} className="w-full h-full object-cover" />
            : <span>{initials(name) || '?'}</span>
          }
        </div>

        {/* Overlay de upload */}
        <div className="absolute inset-0 rounded-full bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
          {uploading
            ? <Loader2 className="w-5 h-5 text-white animate-spin" />
            : <Camera className="w-5 h-5 text-white" />
          }
        </div>

        {/* Botão remover */}
        {preview && !uploading && (
          <button
            type="button"
            onClick={e => { e.stopPropagation(); setPreview(null); onUpload(''); }}
            className="absolute -top-1 -right-1 w-5 h-5 bg-rose-500 text-white rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity shadow"
          >
            <X className="w-3 h-3" />
          </button>
        )}
      </div>

      <input ref={inputRef} type="file" accept="image/*" className="hidden" onChange={handleFile} />

      <p className="text-[10px] text-slate-400 text-center">
        {uploading ? 'Enviando...' : 'Clique para alterar foto'}
      </p>
      {error && <p className="text-[10px] text-rose-500">{error}</p>}
    </div>
  );
};

export default AvatarUpload;
