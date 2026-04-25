import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/service_locator.dart';
import '../utils/token_storage.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/auth/presentation/cubits/specialty_cubit.dart';
import '../../features/auth/presentation/screens/doctor_rejected_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/doctor_onboarding/presentation/cubits/onboarding_cubit.dart';
import '../../features/doctor_onboarding/presentation/screens/doctor_document_upload_screen.dart';
import '../../features/doctor_onboarding/presentation/screens/doctor_pending_screen.dart';

part 'route_names.dart';

/// Main app router with auth redirect and role-based shell navigation.
class AppRouter {
  final TokenStorage _tokenStorage;

  AppRouter() : _tokenStorage = sl<TokenStorage>();

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: _globalRedirect,
    routes: [
      // ─── Splash ───
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // ─── Onboarding ───
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ─── Auth Routes ───
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signUp,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthCubit>()),
            BlocProvider(
              create: (_) => sl<SpecialtyCubit>()..loadSpecialties(),
            ),
          ],
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        name: RouteNames.forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: '/otp',
        name: RouteNames.otp,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'OTP Verification'),
      ),
      GoRoute(
        path: '/reset-password',
        name: RouteNames.resetPassword,
        builder: (context, state) {
          final token = state.uri.queryParameters['token'] ?? '';
          return BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: ResetPasswordScreen(token: token),
          );
        },
      ),

      // ─── Doctor Onboarding ───
      GoRoute(
        path: '/doctor-documents',
        name: RouteNames.doctorDocuments,
        builder: (context, state) {
          final token = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => sl<OnboardingCubit>(),
            child: DoctorDocumentUploadScreen(pendingToken: token),
          );
        },
      ),
      GoRoute(
        path: '/doctor-pending',
        name: RouteNames.doctorPending,
        builder: (context, state) => const DoctorPendingScreen(),
      ),
      GoRoute(
        path: '/doctor-rejected',
        name: RouteNames.doctorRejected,
        builder: (context, state) => DoctorRejectedScreen(
          rejectionReason: state.extra as String?,
        ),
      ),

      // ─── Patient Shell ───
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => _PatientShell(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/patient/home',
              name: RouteNames.patientHome,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Patient Home'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/patient/appointments',
              name: RouteNames.patientAppointments,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Appointments'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/patient/messages',
              name: RouteNames.patientMessages,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Messages'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/patient/records',
              name: RouteNames.patientRecords,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Records'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/patient/profile',
              name: RouteNames.patientProfile,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Profile'),
            ),
          ]),
        ],
      ),

      // ─── Doctor Shell ───
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => _DoctorShell(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/doctor/home',
              name: RouteNames.doctorHome,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Doctor Home'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/doctor/appointments',
              name: RouteNames.doctorAppointments,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Appointments'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/doctor/chat',
              name: RouteNames.doctorChat,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Chat'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/doctor/insights',
              name: RouteNames.doctorInsights,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Insights'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/doctor/profile',
              name: RouteNames.doctorProfile,
              builder: (context, state) =>
                  const _PlaceholderScreen(title: 'Profile'),
            ),
          ]),
        ],
      ),
    ],
  );

  /// Global redirect — checks auth state and role.
  Future<String?> _globalRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final isLoggedIn = await _tokenStorage.hasTokens();
    final currentPath = state.uri.path;

    final authPaths = [
      '/login', '/signup', '/forgot-password', '/otp', '/reset-password',
      '/doctor-documents', '/doctor-pending',
    ];
    final isOnAuthPage = authPaths.contains(currentPath);

    if (!isLoggedIn && !isOnAuthPage && currentPath != '/splash') {
      return '/login';
    }

    if (isLoggedIn && isOnAuthPage) {
      final role = await _tokenStorage.getUserRole();
      return role == 'Doctor' ? '/doctor/home' : '/patient/home';
    }

    return null;
  }
}

// ─── Patient Shell with Bottom Nav ───
class _PatientShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _PatientShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.description_outlined), activeIcon: Icon(Icons.description), label: 'Records'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ─── Doctor Shell with Bottom Nav ───
class _DoctorShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _DoctorShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.insights_outlined), activeIcon: Icon(Icons.insights), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ─── Temporary placeholder screen ───
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await sl<AuthCubit>().logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Signed in successfully!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
