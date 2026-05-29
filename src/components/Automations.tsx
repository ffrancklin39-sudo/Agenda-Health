import React from 'react';
import { Zap, MessageCircle, Mail, Calendar, CheckCircle2 } from 'lucide-react';
import { Patient } from '../types';

interface Props {
  patients: Patient[];
}

const Automations: React.FC<Props> = ({ patients }) => {
  const automations = [
    { id: 1, name: 'Boas-vindas WhatsApp', trigger: 'Novo Lead', action: 'Enviar mensagem', status: 'Ativo', icon: MessageCircle, color: 'emerald' },
    { id: 2, name: 'Lembrete de Consulta', trigger: '24h antes', action: 'Enviar SMS/WhatsApp', status: 'Ativo', icon: Calendar, color: 'blue' },
    { id: 3, name: 'Pesquisa de Satisfação', trigger: 'Pós-consulta', action: 'Enviar Link', status: 'Inativo', icon: Zap, color: 'amber' },
    { id: 4, name: 'E-mail de Aniversário', trigger: 'Data Nasc.', action: 'Enviar E-mail', status: 'Ativo', icon: Mail, color: 'purple' },
    { id: 5, name: 'Projeto Lázaro', trigger: 'Lead Inativo > 30 dias', action: 'Reativação IA', status: 'Ativo', icon: Zap, color: 'rose' },
  ];

  return (
    <div className="space-y-10">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900 tracking-tight">Automações Inteligentes</h2>
          <p className="text-slate-500 text-sm">Otimize o fluxo de comunicação com IA e gatilhos automáticos</p>
        </div>
        <button className="premium-button bg-indigo-600 text-white shadow-xl shadow-indigo-900/20 hover:bg-indigo-700">
          <Zap size={20} />
          <span>Nova Automação</span>
        </button>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {automations.map((auto) => (
          <div key={auto.id} className="bg-white p-10 rounded-2xl shadow-sm hover:shadow-md transition-all duration-500 relative overflow-hidden group">
            <div className={`absolute top-0 right-0 w-48 h-48 bg-${auto.color}-50 rounded-full -mr-24 -mt-24 transition-all duration-700 group-hover:scale-125 blur-3xl opacity-60`} />
            
            <div className="relative z-10">
              <div className={`w-16 h-16 rounded-2xl bg-${auto.color}-50 text-${auto.color}-600 flex items-center justify-center mb-10 shadow-sm group-hover:bg-${auto.color}-600 group-hover:text-white transition-all duration-500`}>
                <auto.icon size={32} />
              </div>
              
              <div className="flex justify-between items-start mb-8">
                <div>
                  <h3 className="text-2xl font-bold text-slate-900 tracking-tight mb-2">{auto.name}</h3>
                  <p className="text-slate-400 text-xs font-bold uppercase tracking-widest">{auto.action}</p>
                </div>
                <span className={`px-4 py-1.5 rounded-lg text-xs font-bold transition-all duration-500 ${auto.status === 'Ativo' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-500'}`}>
                  {auto.status}
                </span>
              </div>
              
              <div className="grid grid-cols-2 gap-6 mb-12">
                <div className="p-6 bg-slate-50 rounded-2xl">
                  <div className="flex items-center text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">
                    <Zap size={14} className="mr-2" /> Gatilho
                  </div>
                  <span className="text-base font-bold text-slate-800">{auto.trigger}</span>
                </div>
                <div className="p-6 bg-slate-50 rounded-2xl">
                  <div className="flex items-center text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">
                    <CheckCircle2 size={14} className="mr-2" /> Status
                  </div>
                  <span className="text-base font-bold text-slate-800">{auto.status === 'Ativo' ? 'Em execução' : 'Pausado'}</span>
                </div>
              </div>
              
              <div className="flex items-center justify-between pt-10 border-t border-slate-50">
                <button className="text-sm font-bold text-indigo-600 hover:text-indigo-700 transition-all uppercase tracking-widest flex items-center gap-2">
                  Configurar Fluxo
                </button>
                <div className="flex items-center space-x-4">
                  <div className={`w-3 h-3 rounded-full ${auto.status === 'Ativo' ? 'bg-emerald-500 animate-pulse shadow-[0_0_10px_rgba(16,185,129,0.5)]' : 'bg-slate-300'}`} />
                  <span className="text-xs font-bold text-slate-400 uppercase tracking-widest">
                    {auto.status === 'Ativo' ? 'IA Ativa' : 'Offline'}
                  </span>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Automations;
