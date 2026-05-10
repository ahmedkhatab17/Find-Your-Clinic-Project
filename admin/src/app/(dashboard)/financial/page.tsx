'use client';

import { useEffect, useState } from 'react';
import {
  DollarSign,
  TrendingUp,
  ArrowLeftRight,
  Clock,
  ChevronLeft,
  ChevronRight,
  Building2,
  User,
  Wallet,
  Landmark,
  AlertCircle,
} from 'lucide-react';
import api from '@/lib/api';

// ─── Types ─────────────────────────────────────────────────────────────────

interface FinancialStats {
  totalRevenue: number;
  totalVolume: number;
  totalTransactions: number;
  paidTransactions: number;
  pendingPayouts: number;
  totalWithdrawn: number;
}

interface AdminTransaction {
  id: string;
  appointmentId: string;
  doctorName: string;
  clinicName: string;
  specialty: string;
  patientName: string;
  consultationFee: number;
  platformFee: number;
  doctorEarnings: number;
  paymentMethod: string;
  status: string;
  createdAt: string;
  completedAt: string | null;
}

interface PagedTransactionsResult {
  items: AdminTransaction[];
  totalCount: number;
  page: number;
  pageSize: number;
}

interface DoctorPayout {
  doctorProfileId: string;
  doctorName: string;
  clinicName: string;
  specialty: string;
  totalEarnings: number;
  pendingBalance: number;
  withdrawnAmount: number;
  totalPaidTransactions: number;
  payoutMethod: string | null;
  walletProvider: string | null;
  walletPhoneNumber: string | null;
  bankName: string | null;
  accountHolderName: string | null;
  accountNumber: string | null;
  iban: string | null;
}

// ─── Helpers ───────────────────────────────────────────────────────────────

const fmt = (n: number) =>
  new Intl.NumberFormat('en-EG', { minimumFractionDigits: 2, maximumFractionDigits: 2 }).format(n);

const statusBadge = (status: string) => {
  const map: Record<string, string> = {
    Paid: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20',
    Pending: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20',
    Refunded: 'bg-blue-500/10 text-blue-400 border-blue-500/20',
    Failed: 'bg-red-500/10 text-red-400 border-red-500/20',
  };
  return map[status] ?? 'bg-gray-500/10 text-gray-400 border-gray-500/20';
};

const methodBadge = (method: string) => {
  const map: Record<string, string> = {
    Card: 'bg-blue-500/10 text-blue-400 border-blue-500/20',
    Wallet: 'bg-purple-500/10 text-purple-400 border-purple-500/20',
    Cash: 'bg-teal-500/10 text-teal-400 border-teal-500/20',
  };
  return map[method] ?? 'bg-gray-500/10 text-gray-400 border-gray-500/20';
};

// ─── Component ─────────────────────────────────────────────────────────────

export default function FinancialPage() {
  const [activeTab, setActiveTab] = useState(0);

  // Overview
  const [stats, setStats] = useState<FinancialStats | null>(null);
  const [statsLoading, setStatsLoading] = useState(true);

  // Transactions
  const [transactions, setTransactions] = useState<AdminTransaction[]>([]);
  const [txLoading, setTxLoading] = useState(true);
  const [txTotal, setTxTotal] = useState(0);
  const [txPage, setTxPage] = useState(1);
  const [txStatus, setTxStatus] = useState('');
  const [txMethod, setTxMethod] = useState('');
  const PAGE_SIZE = 20;

  // Doctor Payouts
  const [doctors, setDoctors] = useState<DoctorPayout[]>([]);
  const [doctorsLoading, setDoctorsLoading] = useState(true);
  const [payingOut, setPayingOut] = useState<string | null>(null);
  const [toast, setToast] = useState<{ message: string; ok: boolean } | null>(null);

  // ─── Data Fetching ────────────────────────────────────────────────────

  useEffect(() => {
    api
      .get('/admin/financial/stats')
      .then((res) => setStats(res.data.data))
      .finally(() => setStatsLoading(false));

    fetchDoctors();
  }, []);

  useEffect(() => {
    fetchTransactions();
  }, [txPage, txStatus, txMethod]);

  const fetchTransactions = async () => {
    setTxLoading(true);
    try {
      const params: Record<string, string | number> = { page: txPage, pageSize: PAGE_SIZE };
      if (txStatus) params.status = txStatus;
      if (txMethod) params.paymentMethod = txMethod;
      const res = await api.get<{ data: PagedTransactionsResult }>('/admin/financial/transactions', { params });
      setTransactions(res.data.data.items);
      setTxTotal(res.data.data.totalCount);
    } finally {
      setTxLoading(false);
    }
  };

  const fetchDoctors = async () => {
    setDoctorsLoading(true);
    try {
      const res = await api.get('/admin/financial/doctors');
      setDoctors(res.data.data ?? []);
    } finally {
      setDoctorsLoading(false);
    }
  };

  const handlePayout = async (doctorProfileId: string) => {
    setPayingOut(doctorProfileId);
    try {
      const res = await api.post(`/admin/financial/doctors/${doctorProfileId}/payout`);
      if (res.data.success) {
        showToast('Payout recorded successfully.', true);
        await fetchDoctors();
      } else {
        showToast(res.data.message ?? 'Payout failed.', false);
      }
    } catch {
      showToast('An error occurred.', false);
    } finally {
      setPayingOut(null);
    }
  };

  const showToast = (message: string, ok: boolean) => {
    setToast({ message, ok });
    setTimeout(() => setToast(null), 3500);
  };

  const totalPages = Math.ceil(txTotal / PAGE_SIZE);

  const changeFilter = (setter: (v: string) => void, value: string) => {
    setter(value);
    setTxPage(1);
  };

  // ─── Render ───────────────────────────────────────────────────────────

  return (
    <div className="p-8 text-white">
      {/* Toast */}
      {toast && (
        <div
          className={`fixed top-6 right-6 z-50 flex items-center gap-3 px-5 py-3 rounded-xl shadow-lg border text-sm font-medium transition-all ${
            toast.ok
              ? 'bg-emerald-900/80 border-emerald-500/30 text-emerald-300'
              : 'bg-red-900/80 border-red-500/30 text-red-300'
          }`}
        >
          <AlertCircle className="w-4 h-4 shrink-0" />
          {toast.message}
        </div>
      )}

      {/* Header */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold mb-2">Financial</h1>
        <p className="text-gray-400">Platform revenue, patient transactions, and doctor commission payouts.</p>
      </div>

      {/* Tabs */}
      <div className="flex gap-1 p-1 bg-gray-900 border border-gray-800 rounded-xl w-fit mb-8">
        {['Overview', 'Transactions', 'Doctor Payouts'].map((tab, i) => (
          <button
            key={tab}
            onClick={() => setActiveTab(i)}
            className={`px-5 py-2 rounded-lg text-sm font-medium transition-colors ${
              activeTab === i
                ? 'bg-blue-600 text-white shadow'
                : 'text-gray-400 hover:text-white hover:bg-gray-800'
            }`}
          >
            {tab}
          </button>
        ))}
      </div>

      {/* ── Tab 0: Overview ─────────────────────────────────────────────── */}
      {activeTab === 0 && (
        <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-5">
          <StatCard
            label="Platform Revenue"
            value={statsLoading ? '...' : `EGP ${fmt(stats?.totalRevenue ?? 0)}`}
            sub="Total platform fees collected"
            icon={<DollarSign className="w-6 h-6" />}
            gradient="from-emerald-900/50 to-emerald-800/20"
            border="border-emerald-500/20"
            iconBg="bg-emerald-500/20"
            iconColor="text-emerald-400"
          />
          <StatCard
            label="Transaction Volume"
            value={statsLoading ? '...' : `EGP ${fmt(stats?.totalVolume ?? 0)}`}
            sub="Total amount processed"
            icon={<TrendingUp className="w-6 h-6" />}
            gradient="from-blue-900/50 to-blue-800/20"
            border="border-blue-500/20"
            iconBg="bg-blue-500/20"
            iconColor="text-blue-400"
          />
          <StatCard
            label="Total Transactions"
            value={statsLoading ? '...' : `${stats?.totalTransactions ?? 0}`}
            sub={`${stats?.paidTransactions ?? 0} paid`}
            icon={<ArrowLeftRight className="w-6 h-6" />}
            gradient="from-purple-900/50 to-purple-800/20"
            border="border-purple-500/20"
            iconBg="bg-purple-500/20"
            iconColor="text-purple-400"
          />
          <StatCard
            label="Pending Payouts"
            value={statsLoading ? '...' : `EGP ${fmt(stats?.pendingPayouts ?? 0)}`}
            sub="Owed to doctors"
            icon={<Clock className="w-6 h-6" />}
            gradient="from-yellow-900/50 to-yellow-800/20"
            border="border-yellow-500/20"
            iconBg="bg-yellow-500/20"
            iconColor="text-yellow-400"
          />
          <StatCard
            label="Total Withdrawn"
            value={statsLoading ? '...' : `EGP ${fmt(stats?.totalWithdrawn ?? 0)}`}
            sub="Paid out to doctors"
            icon={<Wallet className="w-6 h-6" />}
            gradient="from-teal-900/50 to-teal-800/20"
            border="border-teal-500/20"
            iconBg="bg-teal-500/20"
            iconColor="text-teal-400"
          />
        </div>
      )}

      {/* ── Tab 1: Transactions ─────────────────────────────────────────── */}
      {activeTab === 1 && (
        <div className="bg-gray-900 border border-gray-800 rounded-2xl overflow-hidden">
          {/* Filters */}
          <div className="p-4 border-b border-gray-800 bg-gray-800/50 flex flex-wrap gap-4 items-center">
            <div className="flex flex-wrap gap-2">
              <span className="text-xs text-gray-500 self-center mr-1">Status:</span>
              {['', 'Paid', 'Pending', 'Refunded', 'Failed'].map((s) => (
                <button
                  key={s || 'all-status'}
                  onClick={() => changeFilter(setTxStatus, s)}
                  className={`px-3 py-1 text-xs rounded-lg border transition-colors ${
                    txStatus === s
                      ? 'bg-blue-600 border-blue-600 text-white'
                      : 'border-gray-700 text-gray-400 hover:text-white hover:border-gray-500'
                  }`}
                >
                  {s || 'All'}
                </button>
              ))}
            </div>
            <div className="flex flex-wrap gap-2">
              <span className="text-xs text-gray-500 self-center mr-1">Method:</span>
              {['', 'Card', 'Wallet', 'Cash'].map((m) => (
                <button
                  key={m || 'all-method'}
                  onClick={() => changeFilter(setTxMethod, m)}
                  className={`px-3 py-1 text-xs rounded-lg border transition-colors ${
                    txMethod === m
                      ? 'bg-blue-600 border-blue-600 text-white'
                      : 'border-gray-700 text-gray-400 hover:text-white hover:border-gray-500'
                  }`}
                >
                  {m || 'All'}
                </button>
              ))}
            </div>
            <span className="ml-auto text-xs text-gray-500">{txTotal} result{txTotal !== 1 ? 's' : ''}</span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead className="bg-gray-800/50 text-gray-400 font-medium">
                <tr>
                  <th className="px-5 py-3">Date</th>
                  <th className="px-5 py-3">Doctor / Clinic</th>
                  <th className="px-5 py-3">Specialty</th>
                  <th className="px-5 py-3">Patient</th>
                  <th className="px-5 py-3 text-right">Fee (EGP)</th>
                  <th className="px-5 py-3 text-right">Platform Fee</th>
                  <th className="px-5 py-3 text-right">Doctor Earnings</th>
                  <th className="px-5 py-3">Method</th>
                  <th className="px-5 py-3">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-800">
                {txLoading
                  ? Array.from({ length: 6 }).map((_, i) => (
                      <tr key={i} className="animate-pulse">
                        {Array.from({ length: 9 }).map((__, j) => (
                          <td key={j} className="px-5 py-4">
                            <div className="h-3 bg-gray-800 rounded w-20" />
                          </td>
                        ))}
                      </tr>
                    ))
                  : transactions.length === 0
                  ? (
                      <tr>
                        <td colSpan={9} className="px-5 py-14 text-center text-gray-500">
                          No transactions found.
                        </td>
                      </tr>
                    )
                  : transactions.map((tx) => (
                      <tr key={tx.id} className="hover:bg-gray-800/50 transition-colors">
                        <td className="px-5 py-4 text-gray-400 whitespace-nowrap">
                          {new Date(tx.createdAt).toLocaleDateString()}
                        </td>
                        <td className="px-5 py-4">
                          <p className="font-medium text-gray-200">{tx.doctorName}</p>
                          {tx.clinicName && (
                            <p className="text-xs text-gray-500 flex items-center gap-1 mt-0.5">
                              <Building2 className="w-3 h-3" /> {tx.clinicName}
                            </p>
                          )}
                        </td>
                        <td className="px-5 py-4 text-gray-400">{tx.specialty}</td>
                        <td className="px-5 py-4">
                          <p className="text-gray-200 flex items-center gap-1">
                            <User className="w-3 h-3 text-gray-500" /> {tx.patientName}
                          </p>
                        </td>
                        <td className="px-5 py-4 text-right font-medium text-white">{fmt(tx.consultationFee)}</td>
                        <td className="px-5 py-4 text-right text-emerald-400">{fmt(tx.platformFee)}</td>
                        <td className="px-5 py-4 text-right text-blue-400">{fmt(tx.doctorEarnings)}</td>
                        <td className="px-5 py-4">
                          <span className={`inline-flex px-2.5 py-1 rounded-md text-xs font-medium border ${methodBadge(tx.paymentMethod)}`}>
                            {tx.paymentMethod}
                          </span>
                        </td>
                        <td className="px-5 py-4">
                          <span className={`inline-flex px-2.5 py-1 rounded-md text-xs font-medium border ${statusBadge(tx.status)}`}>
                            {tx.status}
                          </span>
                        </td>
                      </tr>
                    ))}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className="flex items-center justify-between px-5 py-4 border-t border-gray-800 bg-gray-800/30">
              <span className="text-sm text-gray-500">
                Page {txPage} of {totalPages}
              </span>
              <div className="flex gap-2">
                <button
                  onClick={() => setTxPage((p) => Math.max(1, p - 1))}
                  disabled={txPage === 1}
                  className="p-2 rounded-lg border border-gray-700 text-gray-400 hover:text-white hover:border-gray-500 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                >
                  <ChevronLeft className="w-4 h-4" />
                </button>
                <button
                  onClick={() => setTxPage((p) => Math.min(totalPages, p + 1))}
                  disabled={txPage === totalPages}
                  className="p-2 rounded-lg border border-gray-700 text-gray-400 hover:text-white hover:border-gray-500 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                >
                  <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}
        </div>
      )}

      {/* ── Tab 2: Doctor Payouts ────────────────────────────────────────── */}
      {activeTab === 2 && (
        <div className="bg-gray-900 border border-gray-800 rounded-2xl overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead className="bg-gray-800/50 text-gray-400 font-medium">
                <tr>
                  <th className="px-5 py-3">Doctor / Clinic</th>
                  <th className="px-5 py-3">Specialty</th>
                  <th className="px-5 py-3 text-right">Total Earned</th>
                  <th className="px-5 py-3 text-right">Pending Payout</th>
                  <th className="px-5 py-3 text-right">Withdrawn</th>
                  <th className="px-5 py-3">Payout Method</th>
                  <th className="px-5 py-3 text-right">Action</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-800">
                {doctorsLoading
                  ? Array.from({ length: 5 }).map((_, i) => (
                      <tr key={i} className="animate-pulse">
                        {Array.from({ length: 7 }).map((__, j) => (
                          <td key={j} className="px-5 py-4">
                            <div className="h-3 bg-gray-800 rounded w-24" />
                          </td>
                        ))}
                      </tr>
                    ))
                  : doctors.length === 0
                  ? (
                      <tr>
                        <td colSpan={7} className="px-5 py-14 text-center text-gray-500">
                          No doctor wallets found.
                        </td>
                      </tr>
                    )
                  : doctors.map((doc) => (
                      <tr key={doc.doctorProfileId} className="hover:bg-gray-800/50 transition-colors">
                        <td className="px-5 py-4">
                          <p className="font-medium text-gray-200">{doc.doctorName}</p>
                          {doc.clinicName && (
                            <p className="text-xs text-gray-500 flex items-center gap-1 mt-0.5">
                              <Building2 className="w-3 h-3" /> {doc.clinicName}
                            </p>
                          )}
                        </td>
                        <td className="px-5 py-4 text-gray-400">{doc.specialty}</td>
                        <td className="px-5 py-4 text-right font-medium text-white">
                          EGP {fmt(doc.totalEarnings)}
                        </td>
                        <td className="px-5 py-4 text-right">
                          <span className={`font-semibold ${doc.pendingBalance > 0 ? 'text-yellow-400' : 'text-gray-500'}`}>
                            EGP {fmt(doc.pendingBalance)}
                          </span>
                        </td>
                        <td className="px-5 py-4 text-right text-emerald-400">
                          EGP {fmt(doc.withdrawnAmount)}
                        </td>
                        <td className="px-5 py-4">
                          <PayoutMethodCell doc={doc} />
                        </td>
                        <td className="px-5 py-4 text-right">
                          {doc.pendingBalance > 0 ? (
                            <button
                              onClick={() => handlePayout(doc.doctorProfileId)}
                              disabled={payingOut === doc.doctorProfileId}
                              className="px-4 py-1.5 bg-emerald-600 hover:bg-emerald-500 disabled:opacity-50 disabled:cursor-not-allowed text-white text-xs font-medium rounded-lg transition-colors"
                            >
                              {payingOut === doc.doctorProfileId ? 'Processing...' : 'Record Payout'}
                            </button>
                          ) : (
                            <span className="inline-flex px-3 py-1.5 bg-gray-800 border border-gray-700 text-gray-500 text-xs rounded-lg">
                              No Pending
                            </span>
                          )}
                        </td>
                      </tr>
                    ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}

// ─── Sub-components ─────────────────────────────────────────────────────────

function StatCard({
  label,
  value,
  sub,
  icon,
  gradient,
  border,
  iconBg,
  iconColor,
}: {
  label: string;
  value: string;
  sub: string;
  icon: React.ReactNode;
  gradient: string;
  border: string;
  iconBg: string;
  iconColor: string;
}) {
  return (
    <div className={`bg-gradient-to-br ${gradient} border ${border} rounded-2xl p-6`}>
      <div className="flex items-start justify-between mb-4">
        <div className={`p-3 ${iconBg} rounded-xl ${iconColor}`}>{icon}</div>
      </div>
      <p className="text-2xl font-bold text-white mb-1">{value}</p>
      <p className="text-sm font-medium text-gray-300">{label}</p>
      <p className="text-xs text-gray-500 mt-0.5">{sub}</p>
    </div>
  );
}

function PayoutMethodCell({ doc }: { doc: DoctorPayout }) {
  if (!doc.payoutMethod) {
    return <span className="text-gray-600 text-xs">Not set</span>;
  }

  if (doc.payoutMethod === 'Wallet') {
    return (
      <div className="flex items-start gap-1.5 text-xs">
        <Wallet className="w-3.5 h-3.5 text-purple-400 mt-0.5 shrink-0" />
        <div>
          <p className="text-purple-400 font-medium">{doc.walletProvider ?? 'Wallet'}</p>
          {doc.walletPhoneNumber && <p className="text-gray-500">{doc.walletPhoneNumber}</p>}
        </div>
      </div>
    );
  }

  return (
    <div className="flex items-start gap-1.5 text-xs">
      <Landmark className="w-3.5 h-3.5 text-blue-400 mt-0.5 shrink-0" />
      <div>
        <p className="text-blue-400 font-medium">{doc.bankName ?? 'Bank'}</p>
        {doc.accountHolderName && <p className="text-gray-400">{doc.accountHolderName}</p>}
        {doc.accountNumber && (
          <p className="text-gray-500">
            ••••{doc.accountNumber.slice(-4)}
          </p>
        )}
      </div>
    </div>
  );
}
