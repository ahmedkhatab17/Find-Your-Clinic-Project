import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme_mode_cubit.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_visibility_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ThemeModeCubit>(),
      child: const _SettingsBody(),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
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
                    children: [
                      _SectionHeader('ACCESSIBILITY'),
                      BlocBuilder<VoiceAssistantVisibilityCubit, bool>(
                        bloc: sl<VoiceAssistantVisibilityCubit>(),
                        builder: (_, enabled) => SwitchListTile(
                          secondary:
                              const Icon(Icons.record_voice_over_outlined),
                          title: const Text('Voice Assistant Card'),
                          subtitle: const Text(
                            'Show the voice assistant card on the home screen',
                          ),
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
              _SectionHeader('APPEARANCE'),
              SwitchListTile(
                secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode_outlined),
                title: const Text('Dark Mode'),
                value: isDark,
                onChanged: (_) =>
                    context.read<ThemeModeCubit>().toggle(),
              ),
              const Divider(height: 1),
              _SectionHeader('ACCOUNT'),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed('changePassword'),
              ),
              const Divider(height: 1),
              _SectionHeader('SUPPORT'),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & Support'),
                subtitle: const Text('FAQs, contact us, legal'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed('helpSupport'),
              ),
              const Divider(height: 1),
              _SectionHeader('ABOUT'),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('App Version'),
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
