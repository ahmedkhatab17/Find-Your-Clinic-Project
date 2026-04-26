'use client';

import { useEffect, useState } from 'react';
import api from '@/lib/api';
import { Plus, Edit2, Trash2, X } from 'lucide-react';

export default function SpecialtiesPage() {
  const [specialties, setSpecialties] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  
  const [formData, setFormData] = useState({
    name: '',
    iconUrl: '',
    isActive: true,
  });

  const fetchSpecialties = async () => {
    try {
      // Admin should be able to get all specialties, assuming the GET endpoint works without auth.
      const response = await api.get('/specialties');
      setSpecialties(response.data.data || []);
    } catch (error) {
      console.error('Error fetching specialties:', error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchSpecialties();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      if (editingId) {
        await api.put(`/specialties/${editingId}`, formData);
      } else {
        await api.post('/specialties', formData);
      }
      setIsModalOpen(false);
      fetchSpecialties();
    } catch (error) {
      console.error('Error saving specialty:', error);
      alert('Failed to save specialty.');
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this specialty?')) return;
    try {
      await api.delete(`/specialties/${id}`);
      fetchSpecialties();
    } catch (error) {
      console.error('Error deleting specialty:', error);
      alert('Failed to delete specialty.');
    }
  };

  const openEditModal = (specialty: any) => {
    setEditingId(specialty.id);
    setFormData({
      name: specialty.name,
      iconUrl: specialty.iconUrl || '',
      isActive: specialty.isActive,
    });
    setIsModalOpen(true);
  };

  const openAddModal = () => {
    setEditingId(null);
    setFormData({ name: '', iconUrl: '', isActive: true });
    setIsModalOpen(true);
  };

  return (
    <div className="p-8 text-white relative">
      <div className="flex justify-between items-end mb-8">
        <div>
          <h1 className="text-3xl font-bold mb-2">Medical Specialties</h1>
          <p className="text-gray-400">Manage specialties available for doctors to select.</p>
        </div>
        <button
          onClick={openAddModal}
          className="bg-blue-600 hover:bg-blue-500 text-white px-5 py-2.5 rounded-xl font-medium transition-colors flex items-center"
        >
          <Plus className="w-5 h-5 mr-2" />
          Add Specialty
        </button>
      </div>

      {isLoading ? (
        <div className="text-gray-400 text-center py-12">Loading specialties...</div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          {specialties.map((specialty) => (
            <div key={specialty.id} className="bg-gray-900 border border-gray-800 rounded-2xl p-6 flex flex-col hover:border-gray-700 transition-colors">
              <div className="flex justify-between items-start mb-4">
                <div className="w-12 h-12 bg-gray-800 rounded-xl flex items-center justify-center text-2xl overflow-hidden border border-gray-700">
                  {specialty.iconUrl ? (
                    <img src={specialty.iconUrl} alt={specialty.name} className="w-full h-full object-cover" />
                  ) : (
                    '🩺'
                  )}
                </div>
                <span className={`px-2.5 py-1 rounded-md text-xs font-medium border ${
                  specialty.isActive 
                    ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' 
                    : 'bg-red-500/10 text-red-400 border-red-500/20'
                }`}>
                  {specialty.isActive ? 'Active' : 'Inactive'}
                </span>
              </div>
              <h3 className="text-lg font-bold text-white mb-4 flex-1">{specialty.name}</h3>
              
              <div className="flex gap-2 border-t border-gray-800 pt-4 mt-auto">
                <button
                  onClick={() => openEditModal(specialty)}
                  className="flex-1 bg-gray-800 hover:bg-gray-700 text-white font-medium py-2 rounded-lg text-sm transition-colors flex items-center justify-center"
                >
                  <Edit2 className="w-4 h-4 mr-2" />
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(specialty.id)}
                  className="bg-red-500/10 hover:bg-red-500/20 text-red-500 font-medium py-2 px-3 rounded-lg text-sm transition-colors"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
          <div className="bg-gray-900 border border-gray-800 rounded-2xl w-full max-w-md shadow-2xl overflow-hidden">
            <div className="flex justify-between items-center p-6 border-b border-gray-800">
              <h2 className="text-xl font-bold">{editingId ? 'Edit Specialty' : 'Add New Specialty'}</h2>
              <button onClick={() => setIsModalOpen(false)} className="text-gray-400 hover:text-white transition-colors">
                <X className="w-5 h-5" />
              </button>
            </div>
            
            <form onSubmit={handleSubmit} className="p-6 space-y-5">
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-1">Specialty Name</label>
                <input
                  type="text"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  required
                  className="w-full bg-gray-800 border border-gray-700 rounded-xl px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                  placeholder="e.g. Cardiology"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-1">Icon URL (optional)</label>
                <input
                  type="url"
                  value={formData.iconUrl}
                  onChange={(e) => setFormData({ ...formData, iconUrl: e.target.value })}
                  className="w-full bg-gray-800 border border-gray-700 rounded-xl px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                  placeholder="https://example.com/icon.png"
                />
              </div>
              
              <div className="flex items-center">
                <input
                  type="checkbox"
                  id="isActive"
                  checked={formData.isActive}
                  onChange={(e) => setFormData({ ...formData, isActive: e.target.checked })}
                  className="w-4 h-4 text-blue-600 bg-gray-800 border-gray-700 rounded focus:ring-blue-500 focus:ring-2"
                />
                <label htmlFor="isActive" className="ml-2 text-sm font-medium text-gray-300">
                  Active (visible to users)
                </label>
              </div>
              
              <div className="flex gap-3 pt-4 border-t border-gray-800">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="flex-1 bg-gray-800 hover:bg-gray-700 text-white font-medium py-2.5 rounded-xl transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="flex-1 bg-blue-600 hover:bg-blue-500 text-white font-medium py-2.5 rounded-xl transition-colors"
                >
                  {editingId ? 'Save Changes' : 'Create'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
