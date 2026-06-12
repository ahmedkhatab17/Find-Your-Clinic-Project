'use client';

import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { Users, FileCheck, Stethoscope, LogOut, LayoutDashboard, ClipboardList, Star, DollarSign, Sun, Moon } from 'lucide-react';
import { useTheme } from 'next-themes';
import { useEffect, useState } from 'react';

export default function Sidebar() {
  const pathname = usePathname();
  const router = useRouter();
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const navigation = [
    { name: 'Dashboard', href: '/', icon: LayoutDashboard },
    { name: 'Approvals', href: '/approvals', icon: FileCheck },
    { name: 'Users', href: '/users', icon: Users },
    { name: 'Specialties', href: '/specialties', icon: Stethoscope },
    { name: 'Health Records', href: '/health-records', icon: ClipboardList },
    { name: 'Reviews', href: '/reviews', icon: Star },
    { name: 'Financial', href: '/financial', icon: DollarSign },
  ];

  const handleLogout = () => {
    localStorage.removeItem('token');
    router.push('/login');
  };

  return (
    <div className="flex flex-col w-64 bg-surface border-r border-border min-h-screen text-foreground/90 transition-colors duration-200">
      <div className="flex items-center justify-center h-20 border-b border-border">
        <h1 className="text-xl font-bold bg-gradient-to-r from-primary to-teal-500 bg-clip-text text-transparent">
          Find Your Clinic
        </h1>
      </div>
      <nav className="flex-1 px-4 py-6 space-y-2">
        {navigation.map((item) => {
          const isActive = pathname === item.href;
          const Icon = item.icon;
          return (
            <Link
              key={item.name}
              href={item.href}
              className={`flex items-center px-4 py-3 rounded-xl transition-all ${
                isActive
                  ? 'bg-primary/10 text-primary font-medium border border-primary/20 shadow-sm dark:shadow-none'
                  : 'hover:bg-surface-alt hover:text-foreground'
              }`}
            >
              <Icon className="w-5 h-5 mr-3" />
              {item.name}
            </Link>
          );
        })}
      </nav>
      <div className="p-4 border-t border-border space-y-1">
        {mounted && (
          <button
            onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
            className="flex items-center w-full px-4 py-3 text-foreground/75 hover:text-foreground rounded-xl hover:bg-surface-alt transition-all"
          >
            {theme === 'dark' ? (
              <>
                <Sun className="w-5 h-5 mr-3 text-amber-500" />
                Light Mode
              </>
            ) : (
              <>
                <Moon className="w-5 h-5 mr-3 text-indigo-400" />
                Dark Mode
              </>
            )}
          </button>
        )}
        <button
          onClick={handleLogout}
          className="flex items-center w-full px-4 py-3 text-red-500 dark:text-red-400 rounded-xl hover:bg-red-500/10 dark:hover:bg-red-500/10 transition-all"
        >
          <LogOut className="w-5 h-5 mr-3" />
          Logout
        </button>
      </div>
    </div>
  );
}
