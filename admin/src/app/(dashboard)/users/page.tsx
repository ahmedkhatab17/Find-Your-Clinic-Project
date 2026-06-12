'use client';

import { useEffect, useState } from 'react';
import { Search, Power, FileText, Trash2, X } from 'lucide-react';
import api from '@/lib/api';
import DocumentsDrawer from '@/components/DocumentsDrawer';

interface User {
  id: string;
  email: string;
  fullName: string;
  role: string;
  isActive: boolean;
  createdAt: string;
  doctorId: string | null;
}

export default function UsersPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [roleFilter, setRoleFilter] = useState('All');
  const [drawerUserId, setDrawerUserId] = useState<string | null>(null);
  const [togglingId, setTogglingId] = useState<string | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<User | null>(null);
  const [deleteReason, setDeleteReason] = useState('');
  const [isDeleting, setIsDeleting] = useState(false);

  useEffect(() => {
    api.get('/admin/users', { params: { page: 1, pageSize: 1000 } })
      .then((res) => setUsers(res.data.data?.items ?? res.data.data ?? []))
      .catch((err) => console.error('Error fetching users:', err))
      .finally(() => setIsLoading(false));
  }, []);

  const requestAvailability = async (doctorId: string) => {
    try {
      await api.post(`/admin/doctors/${doctorId}/request-availability`);
      alert('Availability request sent successfully.');
    } catch {
      alert('Failed to send availability request.');
    }
  };

  const handleToggleActive = async (user: User) => {
    setTogglingId(user.id);
    try {
      let newIsActive: boolean;
      if (user.role === 'Doctor' && user.doctorId) {
        const res = await api.post(`/admin/doctors/${user.doctorId}/toggle-active`);
        newIsActive = res.data.data?.isActive ?? !user.isActive;
      } else {
        const res = await api.post(`/admin/users/${user.id}/toggle-active`);
        newIsActive = res.data.data?.isActive ?? !user.isActive;
      }
      setUsers((prev) =>
        prev.map((u) => u.id === user.id ? { ...u, isActive: newIsActive } : u)
      );
    } catch {
      alert('Failed to update user status.');
    } finally {
      setTogglingId(null);
    }
  };

  const handleDeleteUser = async () => {
    if (!deleteTarget) return;
    setIsDeleting(true);
    try {
      await api.delete(`/admin/users/${deleteTarget.id}`, {
        data: { reason: deleteReason },
      });
      setUsers((prev) => prev.filter((u) => u.id !== deleteTarget.id));
      setDeleteTarget(null);
      setDeleteReason('');
    } catch {
      alert('Failed to delete user.');
    } finally {
      setIsDeleting(false);
    }
  };

  const filteredUsers = users.filter((user) => {
    const matchesSearch =
      user.fullName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      user.email.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesRole = roleFilter === 'All' || user.role === roleFilter;
    return matchesSearch && matchesRole;
  });

  return (
    <div className="p-8 text-foreground">
      <div className="flex justify-between items-end mb-8">
        <div>
          <h1 className="text-3xl font-bold mb-2">Users Directory</h1>
          <p className="text-foreground/70">Manage all registered patients and doctors on the platform.</p>
        </div>
      </div>

      <div className="bg-surface border border-border rounded-2xl overflow-hidden">
        <div className="p-4 border-b border-border flex flex-col sm:flex-row gap-4 justify-between items-center bg-surface-alt/50">
          <div className="relative w-full sm:w-96">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500 w-5 h-5" />
            <input
              type="text"
              placeholder="Search users by name or email..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2.5 bg-surface border border-border rounded-xl text-sm focus:outline-none focus:border-blue-500 transition-colors"
            />
          </div>
          <div className="flex bg-surface rounded-lg p-1 border border-border w-full sm:w-auto">
            {['All', 'Patient', 'Doctor'].map((role) => (
              <button
                key={role}
                onClick={() => setRoleFilter(role)}
                className={`flex-1 sm:flex-none px-4 py-1.5 text-sm font-medium rounded-md transition-colors ${
                  roleFilter === role
                    ? 'bg-primary text-foreground shadow-sm'
                    : 'text-foreground/70 hover:text-foreground hover:bg-surface-alt'
                }`}
              >
                {role}
              </button>
            ))}
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead className="bg-surface-alt/50 text-foreground/70 font-medium">
              <tr>
                <th className="px-6 py-4">Name</th>
                <th className="px-6 py-4">Email</th>
                <th className="px-6 py-4">Role</th>
                <th className="px-6 py-4">Status</th>
                <th className="px-6 py-4">Joined Date</th>
                <th className="px-6 py-4 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border">
              {isLoading ? (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center text-foreground/75">Loading users...</td>
                </tr>
              ) : filteredUsers.length === 0 ? (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center text-foreground/75">No users found matching your search.</td>
                </tr>
              ) : (
                filteredUsers.map((user) => (
                  <tr key={user.id} className="hover:bg-surface-alt/50 transition-colors">
                    <td className="px-6 py-4 font-medium text-foreground">{user.fullName}</td>
                    <td className="px-6 py-4 text-foreground/70">{user.email}</td>
                    <td className="px-6 py-4">
                      <span className={`inline-flex px-2.5 py-1 rounded-md text-xs font-medium border ${
                        user.role === 'Doctor'
                          ? 'bg-teal-50 text-teal-700 border-teal-200 dark:bg-teal-500/10 dark:text-teal-400 dark:border-teal-500/20'
                          : user.role === 'Admin'
                            ? 'bg-purple-50 text-purple-700 border-purple-200 dark:bg-purple-500/10 dark:text-purple-400 dark:border-purple-500/20'
                            : 'bg-blue-50 text-blue-700 border-blue-200 dark:bg-blue-500/10 dark:text-blue-400 dark:border-blue-500/20'
                      }`}>
                        {user.role}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center">
                        <div className={`w-2 h-2 rounded-full mr-2 ${user.isActive ? 'bg-emerald-500' : 'bg-red-500'}`} />
                        <span className={user.isActive ? 'text-foreground/90' : 'text-foreground/50'}>
                          {user.isActive ? 'Active' : 'Inactive'}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-foreground/50">
                      {new Date(user.createdAt).toLocaleDateString()}
                    </td>
                    <td className="px-6 py-4 text-right">
                      <div className="flex items-center justify-end gap-2">
                        <button
                          onClick={() => setDrawerUserId(user.id)}
                          className="p-2 bg-surface-alt hover:bg-surface-alt text-foreground/70 hover:text-foreground border border-border rounded-lg transition-colors"
                          title="View documents"
                        >
                          <FileText className="w-4 h-4" />
                        </button>

                        {user.role !== 'Admin' && (
                          <button
                            onClick={() => handleToggleActive(user)}
                            disabled={togglingId === user.id}
                            title={user.isActive ? 'Deactivate user' : 'Activate user'}
                            className={`p-2 border rounded-lg transition-all disabled:opacity-50 disabled:cursor-not-allowed ${
                              user.isActive
                                ? 'bg-red-50 text-red-600 hover:bg-red-600 hover:text-white border-red-200 dark:bg-red-500/10 dark:text-red-400 dark:hover:bg-red-500 dark:hover:text-foreground dark:border-red-500/20'
                                : 'bg-emerald-50 text-emerald-600 hover:bg-emerald-600 hover:text-white border-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400 dark:hover:bg-emerald-500 dark:hover:text-foreground dark:border-emerald-500/20'
                            }`}
                          >
                            <Power className="w-4 h-4" />
                          </button>
                        )}

                        {user.role !== 'Admin' && (
                          <button
                            onClick={() => { setDeleteTarget(user); setDeleteReason(''); }}
                            title="Delete user"
                            className="p-2 bg-red-50 text-red-600 hover:bg-red-600 hover:text-white border border-red-200 dark:bg-red-500/10 dark:text-red-400 dark:hover:bg-red-500 dark:hover:text-foreground dark:border-red-500/20 rounded-lg transition-all"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        )}

                        {user.role === 'Doctor' && user.doctorId && (
                          <button
                            onClick={() => requestAvailability(user.doctorId!)}
                            className="px-3 py-1.5 bg-blue-50 text-blue-600 hover:bg-blue-100 border border-blue-200 dark:bg-blue-500/10 dark:text-blue-400 dark:hover:bg-blue-500/20 dark:border-blue-500/20 rounded-lg text-xs font-medium transition-colors"
                          >
                            Request Availability
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      <DocumentsDrawer userId={drawerUserId} onClose={() => setDrawerUserId(null)} />

      {/* Delete User Confirmation Modal */}
      {deleteTarget && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-surface border border-border rounded-2xl w-full max-w-md shadow-2xl">
            <div className="flex items-center justify-between p-6 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Delete User</h2>
              <button
                onClick={() => setDeleteTarget(null)}
                className="p-1 hover:bg-surface-alt rounded-lg transition-colors"
              >
                <X className="w-5 h-5 text-foreground/50" />
              </button>
            </div>
            <div className="p-6 space-y-4">
              <p className="text-foreground/80">
                Are you sure you want to permanently delete <strong>{deleteTarget.fullName}</strong> ({deleteTarget.email})?
                This action cannot be undone. An email will be sent to notify the user.
              </p>
              <div>
                <label className="block text-sm font-medium text-foreground/70 mb-1.5">Reason for deletion</label>
                <textarea
                  value={deleteReason}
                  onChange={(e) => setDeleteReason(e.target.value)}
                  placeholder="e.g. Violation of terms of service..."
                  rows={3}
                  className="w-full px-3 py-2 bg-surface border border-border rounded-xl text-sm focus:outline-none focus:border-red-500 transition-colors resize-none"
                />
              </div>
            </div>
            <div className="flex justify-end gap-3 p-6 border-t border-border">
              <button
                onClick={() => setDeleteTarget(null)}
                disabled={isDeleting}
                className="px-4 py-2 text-sm font-medium text-foreground/70 hover:text-foreground bg-surface-alt border border-border rounded-xl transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleDeleteUser}
                disabled={isDeleting || !deleteReason.trim()}
                className="px-4 py-2 text-sm font-medium text-white bg-red-600 hover:bg-red-700 rounded-xl transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isDeleting ? 'Deleting...' : 'Delete User'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
