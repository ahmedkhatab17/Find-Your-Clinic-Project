'use client';

import { useEffect, useState } from 'react';
import api from '@/lib/api';
import { CheckCircle, XCircle, ExternalLink } from 'lucide-react';

export default function ApprovalsPage() {
  const [doctors, setDoctors] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [rejectionReason, setRejectionReason] = useState('');
  const [selectedDoctorId, setSelectedDoctorId] = useState<string | null>(null);

  const fetchPendingDoctors = async () => {
    try {
      const response = await api.get('/admin/doctors/pending');
      setDoctors(response.data.data || []);
    } catch (error) {
      console.error('Error fetching pending doctors:', error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchPendingDoctors();
  }, []);

  const handleApprove = async (id: string) => {
    try {
      await api.post(`/admin/doctors/${id}/approve`);
      fetchPendingDoctors();
    } catch (error) {
      console.error('Error approving doctor:', error);
      alert('Failed to approve doctor.');
    }
  };

  const handleReject = async (id: string) => {
    if (!rejectionReason) {
      alert('Please provide a reason for rejection.');
      return;
    }
    try {
      await api.post(`/admin/doctors/${id}/reject`, { reason: rejectionReason });
      setRejectionReason('');
      setSelectedDoctorId(null);
      fetchPendingDoctors();
    } catch (error) {
      console.error('Error rejecting doctor:', error);
      alert('Failed to reject doctor.');
    }
  };

  if (isLoading) {
    return <div className="p-8 text-white">Loading approvals...</div>;
  }

  return (
    <div className="p-8 text-white">
      <h1 className="text-3xl font-bold mb-8">Pending Approvals</h1>

      {doctors.length === 0 ? (
        <div className="bg-gray-900 border border-gray-800 rounded-2xl p-12 text-center text-gray-400">
          <CheckCircle className="w-16 h-16 mx-auto mb-4 text-gray-600" />
          <h2 className="text-xl font-semibold mb-2">All caught up!</h2>
          <p>There are no doctors pending approval at this time.</p>
        </div>
      ) : (
        <div className="grid gap-6">
          {doctors.map((doctor) => (
            <div key={doctor.doctorId} className="bg-gray-900 border border-gray-800 rounded-2xl p-6 flex flex-col md:flex-row gap-6">
              <div className="flex-1">
                <h3 className="text-xl font-bold text-white mb-1">{doctor.fullName}</h3>
                <p className="text-gray-400 mb-4">{doctor.specialty} • {doctor.email}</p>
                
                <h4 className="text-sm font-semibold text-gray-300 mb-2 mt-4">Uploaded Documents</h4>
                <div className="flex flex-wrap gap-2">
                  {doctor.documentUrls?.map((url: string, index: number) => (
                    <a
                      key={index}
                      href={url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="inline-flex items-center px-3 py-1.5 bg-gray-800 hover:bg-gray-700 rounded-lg text-sm text-blue-400 transition-colors"
                    >
                      <ExternalLink className="w-4 h-4 mr-2" />
                      Document {index + 1}
                    </a>
                  ))}
                  {(!doctor.documentUrls || doctor.documentUrls.length === 0) && (
                    <span className="text-sm text-gray-500">No documents uploaded</span>
                  )}
                </div>
              </div>
              
              <div className="flex flex-col gap-3 min-w-[200px] border-t md:border-t-0 md:border-l border-gray-800 pt-4 md:pt-0 md:pl-6">
                <button
                  onClick={() => handleApprove(doctor.doctorId)}
                  className="w-full bg-emerald-500/10 text-emerald-500 hover:bg-emerald-500 hover:text-white border border-emerald-500/20 font-medium py-2 px-4 rounded-xl transition-all flex items-center justify-center"
                >
                  <CheckCircle className="w-5 h-5 mr-2" />
                  Approve
                </button>
                
                {selectedDoctorId === doctor.doctorId ? (
                  <div className="space-y-3">
                    <textarea
                      value={rejectionReason}
                      onChange={(e) => setRejectionReason(e.target.value)}
                      placeholder="Reason for rejection..."
                      className="w-full bg-gray-800 border border-gray-700 rounded-lg p-2 text-sm text-white focus:outline-none focus:border-red-500 h-20 resize-none"
                    />
                    <div className="flex gap-2">
                      <button
                        onClick={() => handleReject(doctor.doctorId)}
                        className="flex-1 bg-red-500 text-white font-medium py-2 rounded-lg text-sm hover:bg-red-600 transition-colors"
                      >
                        Confirm
                      </button>
                      <button
                        onClick={() => {
                          setSelectedDoctorId(null);
                          setRejectionReason('');
                        }}
                        className="flex-1 bg-gray-700 text-white font-medium py-2 rounded-lg text-sm hover:bg-gray-600 transition-colors"
                      >
                        Cancel
                      </button>
                    </div>
                  </div>
                ) : (
                  <button
                    onClick={() => setSelectedDoctorId(doctor.doctorId)}
                    className="w-full bg-red-500/10 text-red-500 hover:bg-red-500 hover:text-white border border-red-500/20 font-medium py-2 px-4 rounded-xl transition-all flex items-center justify-center"
                  >
                    <XCircle className="w-5 h-5 mr-2" />
                    Reject
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
