import React from 'react';
import { Briefcase, Plus, DollarSign, Clock, Tag } from 'lucide-react';
import { ClinicService } from '../types';

interface Props {
  services: ClinicService[];
}

const ServicesCatalog: React.FC<Props> = ({ services }) => {
  return (
    <div className="space-y-10">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
        <div>
          <h2 className="text-2xl font-bold text-slate-900 tracking-tight">Catálogo de Serviços</h2>
          <p className="text-slate-500 text-sm">Gerencie procedimentos, consultas e tratamentos</p>
        </div>
        <button className="premium-button bg-indigo-600 text-white shadow-lg shadow-indigo-900/20 hover:bg-indigo-700">
          <Plus size={20} />
          <span>Novo Serviço</span>
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {services.map((service) => (
          <div key={service.id} className="glass-card p-10 rounded-[3rem] premium-shadow border border-white/50 relative overflow-hidden group hover:scale-[1.02] transition-all duration-500">
            <div className="absolute top-0 right-0 w-32 h-32 bg-indigo-50 rounded-full -mr-16 -mt-16 blur-3xl opacity-50 transition-all duration-700 group-hover:scale-150"></div>
            
            <div className="relative z-10">
              <div className="flex justify-between items-start mb-8">
                <div className="w-14 h-14 rounded-2xl bg-indigo-50 text-indigo-600 flex items-center justify-center shadow-sm group-hover:bg-indigo-600 group-hover:text-white transition-all duration-500">
                  <Briefcase size={28} />
                </div>
                <span className="px-4 py-1.5 bg-slate-100 text-slate-400 rounded-xl text-[10px] font-black uppercase tracking-widest border border-slate-200">
                  {service.category}
                </span>
              </div>
              
              <h3 className="text-2xl font-bold text-slate-900 tracking-tight mb-6 group-hover:text-primary-700 transition-colors">{service.name}</h3>
              
              <div className="space-y-4 mb-10">
                <div className="flex items-center text-sm">
                  <div className="w-8 h-8 rounded-lg bg-slate-50 flex items-center justify-center mr-3 text-slate-400">
                    <DollarSign size={16} />
                  </div>
                  <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest mr-2">Preço:</span>
                  <span className="font-bold text-slate-800 text-lg tracking-tight">{service.price.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })}</span>
                </div>
                <div className="flex items-center text-sm">
                  <div className="w-8 h-8 rounded-lg bg-slate-50 flex items-center justify-center mr-3 text-slate-400">
                    <Clock size={16} />
                  </div>
                  <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest mr-2">Duração:</span>
                  <span className="font-bold text-slate-800 text-lg tracking-tight">{service.duration} min</span>
                </div>
              </div>
              
              <div className="flex items-center justify-between pt-8 border-t border-slate-50">
                <button className="text-[10px] font-black text-primary-600 hover:text-primary-700 uppercase tracking-widest transition-all">Editar</button>
                <button className="text-[10px] font-black text-rose-500 hover:text-rose-600 uppercase tracking-widest transition-all">Excluir</button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ServicesCatalog;
