import React, { useState, useEffect } from 'react';
import {
  BarChart,
  Bar,
  LineChart,
  Line,
  PieChart,
  Pie,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts';
import { DollarSign, TrendingUp, Users, Calendar, Plus, Eye, Download, Loader2, AlertCircle } from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { Payment, Professional } from '../types';

interface FinanceNewProps {
  userRole: string;
}

const FinanceNew: React.FC<FinanceNewProps> = ({ userRole }) => {
  const [payments, setPayments] = useState<Payment[]>([]);
  const [professionals, setProfessionals] = useState<Professional[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [view, setView] = useState<'dashboard' | 'payments' | 'commissions'>('dashboard');
  const [selectedProfessional, setSelectedProfessional] = useState<string>('all');
  const [dateRange, setDateRange] = useState<'week' | 'month' | 'year'>('month');

  // Fetch data
  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);

      // Fetch payments
      const { data: paymentsData, error: paymentsError } = await supabase
        .from('payments')
        .select('*')
        .order('payment_date', { ascending: false });

      if (paymentsError) throw paymentsError;

      // Fetch professionals
      const { data: professionalsData, error: professionalsError } = await supabase
        .from('professionals')
        .select('*');

      if (professionalsError) throw professionalsError;

      setPayments(paymentsData || []);
      setProfessionals(professionalsData || []);
    } catch (err) {
      console.error('Erro ao buscar dados:', err);
      setError('Erro ao carregar dados financeiros');
    } finally {
      setLoading(false);
    }
  };

  // Calcular métricas
  const filteredPayments = selectedProfessional === 'all'
    ? payments
    : payments.filter(p => p.professional_id === selectedProfessional);

  const totalReceived = filteredPayments
    .filter(p => p.status === 'paid')
    .reduce((sum, p) => sum + (p.amount || 0), 0);

  const totalPending = filteredPayments
    .filter(p => p.status === 'pending')
    .reduce((sum, p) => sum + (p.amount || 0), 0);

  const totalRefunded = filteredPayments
    .filter(p => p.status === 'refunded')
    .reduce((sum, p) => sum + (p.amount || 0), 0);

  const totalTransactions = filteredPayments.length;

  // Dados para gráficos
  const paymentStatusData = [
    { name: 'Recebido', value: filteredPayments.filter(p => p.status === 'paid').length, fill: '#10b981' },
    { name: 'Pendente', value: filteredPayments.filter(p => p.status === 'pending').length, fill: '#f59e0b' },
    { name: 'Reembolso', value: filteredPayments.filter(p => p.status === 'refunded').length, fill: '#ef4444' },
  ];

  const paymentMethodData = [
    {
      name: 'PIX',
      count: filteredPayments.filter(p => p.payment_method === 'pix').length,
      amount: filteredPayments
        .filter(p => p.payment_method === 'pix' && p.status === 'paid')
        .reduce((sum, p) => sum + (p.amount || 0), 0),
    },
    {
      name: 'Cartão',
      count: filteredPayments.filter(p => ['credit_1x','credit_2_6x','credit_7x_plus','debit'].includes(p.payment_method)).length,
      amount: filteredPayments
        .filter(p => ['credit_1x','credit_2_6x','credit_7x_plus','debit'].includes(p.payment_method) && p.status === 'paid')
        .reduce((sum, p) => sum + (p.amount || 0), 0),
    },
    {
      name: 'Dinheiro',
      count: filteredPayments.filter(p => p.payment_method === 'cash').length,
      amount: filteredPayments
        .filter(p => p.payment_method === 'cash' && p.status === 'paid')
        .reduce((sum, p) => sum + (p.amount || 0), 0),
    },
    {
      name: 'Transferência',
      count: filteredPayments.filter(p => p.payment_method === 'transfer').length,
      amount: filteredPayments
        .filter(p => p.payment_method === 'transfer' && p.status === 'paid')
        .reduce((sum, p) => sum + (p.amount || 0), 0),
    },
  ];

  const professionalRevenueData = professionals.map(prof => {
    const profPayments = filteredPayments.filter(p => p.professional_id === prof.id && p.status === 'paid');
    const revenue = profPayments.reduce((sum, p) => sum + (p.amount || 0), 0);
    const commission = profPayments.reduce((sum, p) => sum + (p.commission_amount || 0), 0);
    return {
      name: prof.name.split(' ')[0],
      receita: revenue,
      comissao: commission,
    };
  });

  // Render views
  const renderDashboard = () => (
    <div className="space-y-6">
      {/* KPIs */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg border border-slate-200 p-6 space-y-2">
          <div className="flex items-center justify-between">
            <p className="text-sm font-semibold text-slate-600">RECEBIDO</p>
            <DollarSign className="w-5 h-5 text-emerald-600" />
          </div>
          <p className="text-3xl font-bold text-slate-900">R$ {totalReceived.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</p>
          <p className="text-xs text-slate-500">{filteredPayments.filter(p => p.status === 'paid').length} transações</p>
        </div>

        <div className="bg-white rounded-lg border border-slate-200 p-6 space-y-2">
          <div className="flex items-center justify-between">
            <p className="text-sm font-semibold text-slate-600">PENDENTE</p>
            <Calendar className="w-5 h-5 text-amber-600" />
          </div>
          <p className="text-3xl font-bold text-slate-900">R$ {totalPending.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</p>
          <p className="text-xs text-slate-500">{filteredPayments.filter(p => p.status === 'pending').length} transações</p>
        </div>

        <div className="bg-white rounded-lg border border-slate-200 p-6 space-y-2">
          <div className="flex items-center justify-between">
            <p className="text-sm font-semibold text-slate-600">REEMBOLSOS</p>
            <TrendingUp className="w-5 h-5 text-rose-600" />
          </div>
          <p className="text-3xl font-bold text-slate-900">R$ {totalRefunded.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</p>
          <p className="text-xs text-slate-500">{filteredPayments.filter(p => p.status === 'refunded').length} transações</p>
        </div>

        <div className="bg-white rounded-lg border border-slate-200 p-6 space-y-2">
          <div className="flex items-center justify-between">
            <p className="text-sm font-semibold text-slate-600">TOTAL</p>
            <Users className="w-5 h-5 text-indigo-600" />
          </div>
          <p className="text-3xl font-bold text-slate-900">{totalTransactions}</p>
          <p className="text-xs text-slate-500">transações registradas</p>
        </div>
      </div>

      {/* Gráficos */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Status dos Pagamentos */}
        <div className="bg-white rounded-lg border border-slate-200 p-6">
          <h3 className="text-lg font-bold text-slate-900 mb-4">Status dos Pagamentos</h3>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie data={paymentStatusData} cx="50%" cy="50%" labelLine={false} label={({ name, value }) => `${name}: ${value}`} outerRadius={80} dataKey="value">
                {paymentStatusData.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.fill} />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>

        {/* Métodos de Pagamento */}
        <div className="bg-white rounded-lg border border-slate-200 p-6">
          <h3 className="text-lg font-bold text-slate-900 mb-4">Métodos de Pagamento</h3>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={paymentMethodData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" />
              <YAxis />
              <Tooltip />
              <Bar dataKey="amount" fill="#6366f1" name="Valor (R$)" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>

      {/* Receita por Profissional */}
      <div className="bg-white rounded-lg border border-slate-200 p-6">
        <h3 className="text-lg font-bold text-slate-900 mb-4">Receita por Profissional</h3>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={professionalRevenueData}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip formatter={(value) => `R$ ${value.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`} />
            <Legend />
            <Bar dataKey="receita" fill="#10b981" name="Receita" />
            <Bar dataKey="comissao" fill="#f59e0b" name="Comissão" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );

  const renderPayments = () => (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h3 className="text-lg font-bold text-slate-900">Histórico de Recebimentos</h3>
        <select
          value={selectedProfessional}
          onChange={(e) => setSelectedProfessional(e.target.value)}
          className="px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500"
        >
          <option value="all">Todos os profissionais</option>
          {professionals.map(p => (
            <option key={p.id} value={p.id}>{p.name}</option>
          ))}
        </select>
      </div>

      <div className="bg-white rounded-lg border border-slate-200 overflow-hidden">
        <table className="w-full">
          <thead className="bg-slate-50 border-b border-slate-200">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-bold text-slate-700 uppercase">Data</th>
              <th className="px-6 py-3 text-left text-xs font-bold text-slate-700 uppercase">Profissional</th>
              <th className="px-6 py-3 text-left text-xs font-bold text-slate-700 uppercase">Valor</th>
              <th className="px-6 py-3 text-left text-xs font-bold text-slate-700 uppercase">Método</th>
              <th className="px-6 py-3 text-left text-xs font-bold text-slate-700 uppercase">Status</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-200">
            {filteredPayments.slice(0, 10).map(payment => {
              const prof = professionals.find(p => p.id === payment.professional_id);
              return (
                <tr key={payment.id} className="hover:bg-slate-50">
                  <td className="px-6 py-3 text-sm text-slate-900">
                    {payment.payment_date
                      ? new Date(payment.payment_date).toLocaleDateString('pt-BR')
                      : '-'}
                  </td>
                  <td className="px-6 py-3 text-sm text-slate-900">{prof?.name || '-'}</td>
                  <td className="px-6 py-3 text-sm font-bold text-emerald-600">
                    R$ {(payment.amount || 0).toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
                  </td>
                  <td className="px-6 py-3 text-sm text-slate-600">
                    {payment.payment_method === 'pix' && '💳 PIX'}
                    {['credit_1x','credit_2_6x','credit_7x_plus'].includes(payment.payment_method) && '💳 Crédito'}
                    {payment.payment_method === 'debit' && '💳 Débito'}
                    {payment.payment_method === 'cash' && '💰 Dinheiro'}
                    {payment.payment_method === 'transfer' && '🏦 Transferência'}
                  </td>
                  <td className="px-6 py-3 text-sm">
                    <span
                      className={`px-2 py-1 rounded-full text-[10px] font-bold uppercase ${
                        payment.status === 'paid'
                          ? 'bg-emerald-100 text-emerald-800'
                          : payment.status === 'pending'
                            ? 'bg-amber-100 text-amber-800'
                            : 'bg-rose-100 text-rose-800'
                      }`}
                    >
                      {payment.status === 'paid' ? 'Recebido' : payment.status === 'pending' ? 'Pendente' : 'Reembolsado'}
                    </span>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );

  const renderCommissions = () => (
    <div className="space-y-4">
      <h3 className="text-lg font-bold text-slate-900">Comissões por Profissional</h3>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {professionals.map(prof => {
          const profPayments = filteredPayments.filter(p => p.professional_id === prof.id && p.status === 'paid');
          const totalRevenue = profPayments.reduce((sum, p) => sum + (p.amount || 0), 0);
          const totalCommission = profPayments.reduce((sum, p) => sum + (p.commission_amount || 0), 0);
          const paidCommission = profPayments
            .filter(p => (p as any).commission_paid)
            .reduce((sum, p) => sum + (p.commission_amount || 0), 0);
          const pendingCommission = totalCommission - paidCommission;

          return (
            <div key={prof.id} className="bg-white rounded-lg border border-slate-200 p-6 space-y-3">
              <div className="flex items-center space-x-3">
                <div className={`w-3 h-3 rounded-full`} style={{ backgroundColor: `#${Math.floor(Math.random() * 16777215).toString(16)}` }} />
                <h4 className="font-bold text-slate-900">{prof.name}</h4>
              </div>

              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span className="text-slate-600">Receita Total:</span>
                  <span className="font-bold text-slate-900">R$ {totalRevenue.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-600">Comissão Total:</span>
                  <span className="font-bold text-amber-600">R$ {totalCommission.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-600">Comissão Paga:</span>
                  <span className="font-bold text-emerald-600">R$ {paidCommission.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-600">Pendente:</span>
                  <span className="font-bold text-rose-600">R$ {pendingCommission.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );

  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <Loader2 className="w-8 h-8 text-indigo-600 animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold text-slate-900">Financeiro</h1>
        <div className="flex items-center space-x-2 bg-slate-100 rounded-lg p-1">
          {(['dashboard', 'payments', 'commissions'] as const).map(v => (
            <button
              key={v}
              onClick={() => setView(v)}
              className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${
                view === v
                  ? 'bg-white text-indigo-600 shadow-sm'
                  : 'text-slate-600 hover:text-slate-900'
              }`}
            >
              {v === 'dashboard' ? '📊 Dashboard' : v === 'payments' ? '💰 Recebimentos' : '🎯 Comissões'}
            </button>
          ))}
        </div>
      </div>

      {/* Error */}
      {error && (
        <div className="flex items-center space-x-3 p-4 bg-rose-50 border border-rose-200 rounded-lg">
          <AlertCircle size={20} className="text-rose-600" />
          <p className="text-sm text-rose-800">{error}</p>
        </div>
      )}

      {/* Content */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        {view === 'dashboard' && renderDashboard()}
        {view === 'payments' && renderPayments()}
        {view === 'commissions' && renderCommissions()}
      </div>
    </div>
  );
};

export default FinanceNew;
