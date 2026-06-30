'use client';

import { useState } from 'react';
import Sidebar from '@/components/Sidebar';
import { Menu } from 'lucide-react';

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="flex h-screen bg-background overflow-hidden">
      {sidebarOpen && (
        <div 
          className="fixed inset-0 z-40 bg-black/50 md:hidden" 
          onClick={() => setSidebarOpen(false)}
        />
      )}
      
      <div className={`fixed inset-y-0 left-0 z-50 transform ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'} md:relative md:translate-x-0 transition-transform duration-200 ease-in-out`}>
        <Sidebar onClose={() => setSidebarOpen(false)} />
      </div>

      <main className="flex-1 overflow-y-auto flex flex-col min-w-0">
        <div className="md:hidden flex items-center p-4 border-b border-border bg-surface shrink-0">
          <button onClick={() => setSidebarOpen(true)} className="p-2 -ml-2 text-foreground/70 hover:text-foreground">
            <Menu className="w-6 h-6" />
          </button>
          <span className="ml-2 font-bold bg-gradient-to-r from-primary to-teal-500 bg-clip-text text-transparent">Find Your Clinic</span>
        </div>
        <div className="flex-1 relative">
          {children}
        </div>
      </main>
    </div>
  );
}
