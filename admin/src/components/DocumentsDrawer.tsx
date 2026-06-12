'use client';

import { useEffect, useState } from 'react';
import { X, ExternalLink, FileText } from 'lucide-react';
import api from '@/lib/api';

interface DocumentDto {
  url: string;
  name: string;
  type: string;
  uploadedAt: string;
}

interface DocumentsDrawerProps {
  userId: string | null;
  onClose: () => void;
}

export default function DocumentsDrawer({ userId, onClose }: DocumentsDrawerProps) {
  const [documents, setDocuments] = useState<DocumentDto[]>([]);
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (!userId) return;
    setIsLoading(true);
    api.get(`/admin/users/${userId}/documents`)
      .then((res) => setDocuments(res.data.data ?? []))
      .catch(() => setDocuments([]))
      .finally(() => setIsLoading(false));
  }, [userId]);

  if (!userId) return null;

  return (
    <>
      <div
        className="fixed inset-0 bg-black/50 z-40"
        onClick={onClose}
      />
      <div className="fixed right-0 top-0 h-full w-96 bg-surface border-l border-border z-50 flex flex-col shadow-2xl">
        <div className="flex items-center justify-between p-6 border-b border-border">
          <h2 className="text-lg font-semibold text-foreground">Documents</h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-surface-alt rounded-lg transition-colors text-foreground/70 hover:text-foreground"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="flex-1 overflow-y-auto p-6">
          {isLoading ? (
            <p className="text-foreground/70 text-sm">Loading documents...</p>
          ) : documents.length === 0 ? (
            <div className="text-center py-12">
              <FileText className="w-12 h-12 mx-auto mb-3 text-gray-600" />
              <p className="text-foreground/70 text-sm">No documents uploaded.</p>
            </div>
          ) : (
            <div className="space-y-3">
              {documents.map((doc, index) => (
                <div
                  key={index}
                  className="bg-surface-alt rounded-xl p-4 border border-border"
                >
                  <div className="flex items-start justify-between gap-3">
                    <div className="flex-1 min-w-0">
                      <p className="text-foreground text-sm font-medium truncate">{doc.name}</p>
                      <p className="text-foreground/70 text-xs mt-1">{doc.type}</p>
                      <p className="text-gray-500 text-xs mt-1">
                        {new Date(doc.uploadedAt).toLocaleDateString()}
                      </p>
                    </div>
                    {doc.url && (
                      <a
                        href={doc.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="shrink-0 p-2 bg-blue-500/10 hover:bg-blue-500/20 text-blue-400 rounded-lg transition-colors"
                      >
                        <ExternalLink className="w-4 h-4" />
                      </a>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </>
  );
}
