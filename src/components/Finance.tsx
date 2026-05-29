import React, { useState, useMemo } from 'react';
import {
  DollarSign, TrendingUp, Users, Target, Calendar,
  Download, ArrowRight, BarChart3, Flame, Zap,
} from 'lucide-react';
import { Patient, UserRole } from '../types';

interface Props { userRole: UserRole; patients: Patient[]; }
type PeriodKey = 'mes' | 'trimestre' | 'ano' | 'custom';
const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];

const Finance: React.FC<Props> = ({ patients }) => {
  const now = new Date();
  const [period, setPeriod]           = useState<PeriodKey>('mes');
  const [customStart, setCustomStart] = useState('');
  const [customEnd,   setCustomEnd]   = useState('');
  const [source, setSource]           = useState('todos');

  const { start, end } = useMemo(() => {
    const y = now.getFullYear(), m = now.getMonth();
    if (period === 'mes')       return { start: new Date(y,m,1),     end: new Date(y,m+1,0,23,59,59) };
    if (period === 'trimestre') return { start: new Date(y,m-2,1),   end: new Date(y,m+1,0,23,59,59) };
    if (period === 'ano')       return { start: new Date(y,0,1),     end: new Date(y,11,31,23,59,59) };
    return {
      start: customStart ? new Date(customStart) : new Date(y,m,1),
      end:   customEnd   ? new Date(customEnd+'T23:59:59') : new Date(y,m+1,0,23,59,59),
    };
  }, [period, customStart, customEnd]);

  const periodLabel = period === 'mes' ? MONTHS[now.getMonth()]+'/'+now.getFullYear()
    : period === 'trimestre' ? 'Últimos 3 meses'
    : period === 'ano'       ? 'Ano '+now.getFullYear()
    : (customStart && customEnd) ? customStart.split('-').reverse().join('/')+' a '+customEnd.split('-').reverse().join('/')
    : 'Período personalizado';

  const inPeriod = (d?: string|null) => { if (!d) return false; const dt=new Date(d); return dt>=start&&dt<=end; };
  const matchSrc = (p: Patient) => {
    if (source==='todos') return true;
    const s=((p as any).source||'').toLowerCase();
    if (source==='meta')   return s.includes('meta')||s.includes('instagram')||s.includes('facebook');
    if (source==='google') return s.includes('google');
    return !s.includes('meta')&&!s.includes('instagram')&&!s.includes('facebook')&&!s.includes('google');
  };

  const CONFIRM = ['confirmed','confirmado','pago'];
  const SCHED   = ['scheduled','agendado'];
  const LEAD_ST = ['lead','novos leads','new','novo','negotiation','waiting'];
  const COLD    = ['discarded'];

  const metrics = useMemo(() => {
    const pp = patients.filter(p => matchSrc(p));
    const leadsIn   = pp.filter(p => inPeriod(p.created_at) && LEAD_ST.includes((p.status||'').toLowerCase()));
    const attended  = pp.filter(p => CONFIRM.includes((p.status||'').toLowerCase()) && inPeriod(p.appointment_date||p.appointmentDate));
    const scheduled = pp.filter(p => SCHED.includes((p.status||'').toLowerCase()) && inPeriod(p.appointment_date||p.appointmentDate));
    const revenue   = attended.reduce((a,p)=>a+(p.price||0),0);
    const ticket    = attended.length ? revenue/attended.length : 0;
    const total     = leadsIn.length+attended.length;
    const conversion= total ? Math.round(attended.length/total*100) : 0;
    const allInPeriod = pp.filter(p=>inPeriod(p.created_at));
    const lost      = allInPeriod.filter(p=>COLD.includes((p.status||'').toLowerCase())).length;
    return { leadsIn: leadsIn.length, attended: attended.length, scheduled: scheduled.length, revenue, ticket, conversion, lost };
  }, [patients, start, end, source]);

  const lazaro = useMemo(() => ({
    cold: patients.filter(p=>COLD.includes((p.status||'').toLowerCase())).length,
    recovered: 0, rate: 0,
  }), [patients]);

  const tableRows = useMemo(() =>
    patients.filter(p=>CONFIRM.includes((p.status||'').toLowerCase())&&inPeriod(p.appointment_date||p.appointmentDate)&&matchSrc(p))
      .sort((a,b)=>new Date(b.appointment_date||b.appointmentDate||'').getTime()-new Date(a.appointment_date||a.appointmentDate||'').getTime()),
  [patients, start, end, source]);

  const funnelData = [
    { label:'Leads', value: metrics.leadsIn,    color:'bg-indigo-500', pct:100 },
    { label:'Agendados', value: metrics.scheduled, color:'bg-purple-500', pct: metrics.leadsIn ? Math.round(metrics.scheduled/metrics.leadsIn*100) : 0 },
    { label:'Atendidos', value: metrics.attended,  color:'bg-emerald-500', pct: metrics.leadsIn ? Math.round(metrics.attended/metrics.leadsIn*100) : 0 },
    { label:'Perdidos',  value: metrics.lost,       color:'bg-slate-300', pct: metrics.leadsIn ? Math.round(metrics.lost/metrics.leadsIn*100) : 0 },
  ];

  const exportCSV = () => {
    const rows = tableRows.map(p=>`"${p.name}","${p.phone||''}","${(p as any).source||''}","${p.appointment_date?new Date(p.appointment_date).toLocaleDateString('pt-BR'):''}","${(p.price||0).toFixed(2)}"`);
    const blob = new Blob(['﻿Nome,Telefone,Origem,Data,Valor\n'+rows.join('\n')],{type:'text/csv;charset=utf-8'});
    const a=document.createElement('a'); a.href=URL.createObjectURL(blob); a.download=`relatorio-${periodLabel.replace(/\//g,'-')}.csv`; a.click();
  };

  const fmt = (v:number) => v.toLocaleString('pt-BR',{style:'currency',currency:'BRL'});
  const fmtD = (s?:string|null) => s ? new Date(s).toLocaleDateString('pt-BR') : '—';

  return (
    <div className="space-y-4 animate-in fade-in duration-500">

      {/* Header + filtros */}
      <div className="flex flex-wrap items-center justify-between gap-2">
        <div>
          <h2 className="text-lg font-bold text-slate-900">Relatórios <span className="text-slate-400 font-normal text-sm">— {periodLabel}</span></h2>
        </div>
        <div className="flex flex-wrap items-center gap-1.5">
          {(['mes','trimestre','ano','custom'] as PeriodKey[]).map(p=>(
            <button key={p} onClick={()=>setPeriod(p)}
              className={`px-2.5 py-1 rounded-lg text-xs font-bold transition-colors ${period===p?'bg-indigo-600 text-white':'bg-white border border-slate-200 text-slate-600 hover:bg-slate-50'}`}>
              {p==='mes'?'Este mês':p==='trimestre'?'3 meses':p==='ano'?'Este ano':'Período'}
            </button>
          ))}
          <select value={source} onChange={e=>setSource(e.target.value)}
            className="px-2.5 py-1 rounded-lg text-xs font-bold bg-white border border-slate-200 text-slate-600 outline-none">
            <option value="todos">Todas origens</option>
            <option value="meta">Meta</option>
            <option value="google">Google</option>
            <option value="manual">Indicação</option>
          </select>
          <button onClick={exportCSV} className="flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-bold bg-white border border-slate-200 text-slate-600 hover:bg-slate-50">
            <Download size={12}/> CSV
          </button>
        </div>
      </div>

      {/* Período customizado */}
      {period==='custom' && (
        <div className="flex items-center gap-2 p-3 bg-slate-50 rounded-xl border border-slate-200">
          <Calendar size={13} className="text-slate-400"/>
          <input type="date" value={customStart} onChange={e=>setCustomStart(e.target.value)} className="px-2 py-1 rounded border border-slate-200 text-xs bg-white outline-none"/>
          <ArrowRight size={12} className="text-slate-400"/>
          <input type="date" value={customEnd} onChange={e=>setCustomEnd(e.target.value)} className="px-2 py-1 rounded border border-slate-200 text-xs bg-white outline-none"/>
        </div>
      )}

      {/* Cards + Funil + Lázaro em uma linha */}
      <div className="grid grid-cols-12 gap-4">

        {/* Cards 2x2 */}
        <div className="col-span-12 lg:col-span-5 grid grid-cols-2 gap-3">
          {[
            { label:'Faturamento', value:fmt(metrics.revenue), icon:DollarSign, color:'text-emerald-600', bg:'bg-emerald-50' },
            { label:'Atendimentos', value:metrics.attended, icon:Users, color:'text-indigo-600', bg:'bg-indigo-50' },
            { label:'Ticket Médio', value:fmt(metrics.ticket), icon:TrendingUp, color:'text-sky-600', bg:'bg-sky-50' },
            { label:'Conversão', value:`${metrics.conversion}%`, icon:Target, color:'text-amber-600', bg:'bg-amber-50' },
          ].map((c,i)=>(
            <div key={i} className="bg-white rounded-xl border border-slate-100 shadow-sm p-4 flex items-center gap-3">
              <div className={`p-2.5 rounded-lg ${c.bg} ${c.color} shrink-0`}><c.icon size={18}/></div>
              <div>
                <p className="text-[10px] font-bold uppercase tracking-widest text-slate-400">{c.label}</p>
                <p className="text-base font-extrabold text-slate-900 leading-tight">{c.value}</p>
              </div>
            </div>
          ))}
        </div>

        {/* Funil */}
        <div className="col-span-12 lg:col-span-3 bg-white rounded-xl border border-slate-100 shadow-sm p-4">
          <p className="text-xs font-bold text-slate-700 flex items-center gap-1.5 mb-3"><BarChart3 size={13} className="text-indigo-500"/>Funil</p>
          <div className="space-y-2.5">
            {funnelData.map((f,i)=>(
              <div key={i}>
                <div className="flex justify-between text-[11px] font-semibold text-slate-600 mb-0.5">
                  <span>{f.label}</span><span className="font-bold">{f.value} <span className="text-slate-400 font-normal">({f.pct}%)</span></span>
                </div>
                <div className="w-full h-1.5 bg-slate-100 rounded-full overflow-hidden">
                  <div className={`h-full ${f.color} rounded-full`} style={{width:`${f.pct}%`}}/>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Projeto Lázaro */}
        <div className="col-span-12 lg:col-span-4 bg-white rounded-xl border border-slate-100 shadow-sm p-4">
          <div className="flex items-center gap-1.5 mb-1">
            <Flame size={13} className="text-orange-500"/>
            <p className="text-xs font-bold text-slate-700">Projeto Lázaro</p>
            <span className="text-[9px] font-black bg-orange-100 text-orange-500 px-1 py-0.5 rounded uppercase">Em breve</span>
          </div>
          <p className="text-[10px] text-slate-400 mb-3">Leads frios reativados pela Sofia</p>
          <div className="grid grid-cols-3 gap-2 mb-3">
            {[
              { label:'Frios', value:lazaro.cold, cl:'text-slate-600', bg:'bg-slate-50 border-slate-200' },
              { label:'Recuperados', value:lazaro.recovered, cl:'text-orange-500', bg:'bg-orange-50 border-orange-100' },
              { label:'Taxa', value:`${lazaro.rate}%`, cl:'text-emerald-600', bg:'bg-emerald-50 border-emerald-100' },
            ].map((s,i)=>(
              <div key={i} className={`rounded-lg p-2.5 text-center border ${s.bg}`}>
                <p className={`text-lg font-black ${s.cl}`}>{s.value}</p>
                <p className="text-[9px] font-bold uppercase tracking-wide text-slate-400 mt-0.5">{s.label}</p>
              </div>
            ))}
          </div>
          <div className="p-2 bg-indigo-50 rounded-lg border border-indigo-100 flex gap-1.5">
            <Zap size={12} className="text-indigo-500 mt-0.5 shrink-0"/>
            <p className="text-[10px] text-indigo-600 leading-relaxed">+5 dias sem resposta → Lázaro. Sofia envia toda segunda. Resposta = volta ao funil.</p>
          </div>
        </div>
      </div>

      {/* Tabela */}
      <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
        <div className="px-4 py-3 border-b border-slate-100 flex items-center justify-between">
          <p className="text-xs font-bold text-slate-700">Atendimentos realizados <span className="text-slate-400 font-normal">({tableRows.length})</span></p>
          <button onClick={exportCSV} className="flex items-center gap-1 text-xs font-bold text-indigo-600 hover:text-indigo-800">
            <Download size={12}/> Exportar
          </button>
        </div>
        {tableRows.length===0 ? (
          <div className="py-10 text-center text-slate-400 text-sm">Nenhum atendimento no período.</div>
        ) : (
          <table className="w-full text-left" style={{tableLayout:'fixed'}}>
            <colgroup>
              <col style={{width:'28%'}}/><col style={{width:'16%'}}/><col style={{width:'16%'}}/><col style={{width:'16%'}}/><col style={{width:'14%'}}/>
            </colgroup>
            <thead>
              <tr className="bg-slate-50 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                <th className="px-4 py-2">Paciente</th><th className="px-4 py-2">Telefone</th>
                <th className="px-4 py-2">Origem</th><th className="px-4 py-2">Data</th>
                <th className="px-4 py-2 text-right">Valor</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50 text-xs">
              {tableRows.map(p=>(
                <tr key={p.id} className="hover:bg-slate-50 transition-colors">
                  <td className="px-4 py-2 font-semibold text-slate-800 truncate">{p.name}</td>
                  <td className="px-4 py-2 text-slate-500 truncate">{p.phone||'—'}</td>
                  <td className="px-4 py-2 text-slate-500 truncate">{(p as any).source||'—'}</td>
                  <td className="px-4 py-2 text-slate-500">{fmtD(p.appointment_date||p.appointmentDate)}</td>
                  <td className="px-4 py-2 text-right font-bold text-emerald-600">{p.price?fmt(p.price):'—'}</td>
                </tr>
              ))}
            </tbody>
            <tfoot>
              <tr className="bg-slate-50 border-t border-slate-200">
                <td colSpan={4} className="px-4 py-2 text-xs font-bold text-slate-500">Total</td>
                <td className="px-4 py-2 text-right text-sm font-black text-emerald-700">{fmt(metrics.revenue)}</td>
              </tr>
            </tfoot>
          </table>
        )}
      </div>
    </div>
  );
};

export default Finance;
