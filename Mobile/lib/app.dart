import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

class FindYourClinicApp extends StatefulWidget {
  const FindYourClinicApp({super.key});

  @override
  State<FindYourClinicApp> createState() => _FindYourClinicAppState();
}

class _FindYourClinicAppState extends State<FindYourClinicApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Find Your Clinic',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.router,
      // Localization will be added in Phase 9
      // localizationsDelegates: [...],
      // supportedLocales: [...],
    );
  }
}
