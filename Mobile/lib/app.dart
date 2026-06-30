import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/generated/app_localizations.dart';
import 'core/locale/locale_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_cubit.dart';
import 'core/di/service_locator.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeModeCubit>(
          create: (_) => sl<ThemeModeCubit>()..load(),
        ),
        BlocProvider<LocaleCubit>(
          create: (_) => sl<LocaleCubit>()..load(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale?>(
        builder: (context, locale) {
          return BlocBuilder<ThemeModeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final fontFamily = locale?.languageCode == 'ar' ? 'Cairo' : 'Inter';
              
              return MaterialApp.router(
                title: 'Find Your Clinic',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light.copyWith(
                  textTheme: GoogleFonts.getTextTheme(
                    fontFamily,
                    AppTheme.light.textTheme,
                  ),
                ),
                darkTheme: AppTheme.dark.copyWith(
                  textTheme: GoogleFonts.getTextTheme(
                    fontFamily,
                    AppTheme.dark.textTheme,
                  ),
                ),
                themeMode: themeMode,
                locale: locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                routerConfig: _appRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
