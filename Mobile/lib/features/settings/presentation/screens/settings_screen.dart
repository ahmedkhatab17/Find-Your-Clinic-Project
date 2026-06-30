// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locale/locale_cubit.dart';
import '../../../../core/theme/theme_mode_cubit.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_visibility_cubit.dart';
import '../../../accessibility/domain/entities/screen_context.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_cubit.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart' as import_auth;
import '../../../auth/presentation/cubits/auth_state.dart' as import_auth;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ThemeModeCubit>()),
        BlocProvider.value(value: sl<LocaleCubit>()),
      ],
      child: const _SettingsBody(),
    );
  }
}

class _SettingsBody extends StatefulWidget {
  const _SettingsBody();

  @override
  State<_SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  static const _screenContext = ScreenContext(screen: PatientScreen.settings);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<VoiceAssistantCubit>().setScreenContext(
            _screenContext,
            summary: _buildScreenSummary,
          );
    });
  }

  String _buildScreenSummary() {
    return AppLocalizations.of(context).settings;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final isDark = themeMode == ThemeMode.dark ||
              (themeMode == ThemeMode.system &&
                  MediaQuery.platformBrightnessOf(context) ==
                      Brightness.dark);
          return ListView(
            children: [
              // ACCESSIBILITY section is patient-only — the voice assistant is
              // a blind-patient feature.
              FutureBuilder<String?>(
                future: sl<TokenStorage>().getUserRole(),
                builder: (ctx, snap) {
                  if (snap.data != 'Patient') return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionHeader(l10n.accessibilitySection),
                      BlocBuilder<VoiceAssistantVisibilityCubit, bool>(
                        bloc: sl<VoiceAssistantVisibilityCubit>(),
                        builder: (_, enabled) => SwitchListTile(
                          secondary:
                              const Icon(Icons.record_voice_over_outlined),
                          title: Text(l10n.voiceAssistantCard),
                          subtitle: Text(l10n.voiceAssistantCardSubtitle),
                          value: enabled,
                          onChanged: (v) =>
                              sl<VoiceAssistantVisibilityCubit>().setEnabled(v),
                        ),
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
              _SectionHeader(l10n.appearance),
              SwitchListTile(
                secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode_outlined),
                title: Text(l10n.darkMode),
                value: isDark,
                onChanged: (_) =>
                    context.read<ThemeModeCubit>().toggle(),
              ),
              const Divider(height: 1),
              _SectionHeader(l10n.language),
              BlocBuilder<LocaleCubit, Locale?>(
                builder: (context, locale) {
                  return Column(
                    children: [
                      // ignore: deprecated_member_use
                      RadioListTile<String?>(
                        title: Text(l10n.systemDefault),
                        value: null,
                        groupValue: locale?.languageCode,
                        onChanged: (_) => context.read<LocaleCubit>().setLocale(null),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      // ignore: deprecated_member_use
                      RadioListTile<String?>(
                        title: Text(l10n.english),
                        value: 'en',
                        groupValue: locale?.languageCode,
                        onChanged: (_) => context.read<LocaleCubit>().setLocale(const Locale('en')),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      // ignore: deprecated_member_use
                      RadioListTile<String?>(
                        title: Text(l10n.arabic),
                        value: 'ar',
                        groupValue: locale?.languageCode,
                        onChanged: (_) => context.read<LocaleCubit>().setLocale(const Locale('ar')),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ],
                  );
                },
              ),
              const Divider(height: 1),
              _SectionHeader(l10n.account),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: Text(l10n.changePassword),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed('changePassword'),
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(l10n.deleteAccount, style: const TextStyle(color: Colors.red)),
                onTap: () => _showDeleteAccountDialog(context),
              ),
              const Divider(height: 1),
              _SectionHeader(l10n.support),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(l10n.helpAndSupport),
                subtitle: Text(l10n.helpAndSupportSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed('helpSupport'),
              ),
              const Divider(height: 1),
              _SectionHeader(l10n.aboutSection),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.appVersion),
                trailing: Text(
                  '1.0.0',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface
                            .withAlpha(120),
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) async {
    final isGoogleUser = await sl<TokenStorage>().isGoogleUser();
    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context);
    final passwordController = TextEditingController();
    final authCubit = sl<import_auth.AuthCubit>();
    
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: authCubit,
        child: BlocConsumer<import_auth.AuthCubit, import_auth.AuthState>(
          listener: (context, state) {
            if (state is import_auth.AuthAccountDeletionRequested) {
              Navigator.of(context).pop(); // close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.deleteAccountSuccess),
                  backgroundColor: Colors.green,
                ),
              );
              // Log out the user since their account is now inactive
              authCubit.logout();
            } else if (state is import_auth.AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is import_auth.AuthLoading;
            return AlertDialog(
              title: Text(l10n.deleteAccountTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.deleteAccountConfirm),
                  if (!isGoogleUser) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: l10n.enterPasswordToConfirm,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (!isGoogleUser && passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.pleaseEnterPassword),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          context.read<import_auth.AuthCubit>().requestAccountDeletion(
                                password: passwordController.text,
                              );
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(l10n.deleteAccount),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withAlpha(140),
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
