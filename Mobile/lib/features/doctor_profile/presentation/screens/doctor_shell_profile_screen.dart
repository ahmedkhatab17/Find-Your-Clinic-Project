import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../cubits/doctor_shell_profile_cubit.dart';
import '../cubits/doctor_shell_profile_state.dart';

class DoctorShellProfileScreen extends StatelessWidget {
  const DoctorShellProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DoctorShellProfileCubit, DoctorShellProfileState>(
        listener: (context, state) {
          if (state is DoctorShellProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DoctorShellProfileLoading ||
              state is DoctorShellProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DoctorShellProfileError) {
            return ErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<DoctorShellProfileCubit>().loadProfile(),
            );
          }
          if (state is! DoctorShellProfileLoaded) {
            return const SizedBox.shrink();
          }
          return _ProfileBody(state: state);
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final DoctorShellProfileLoaded state;
  const _ProfileBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () => context.read<DoctorShellProfileCubit>().loadProfile(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          // ─── Header card ───
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.outline.withAlpha(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    UserAvatar(
                      radius: 32,
                      imageUrl: state.profileImageUrl,
                      fullName: state.fullName,
                      backgroundColor: AppColors.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.fullName,
                            style: AppTextStyles.heading3.copyWith(
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            context.l10n.specialtySpecialist(state.specialty),
                            style: AppTextStyles.bodySm.copyWith(
                              color: cs.onSurface.withAlpha(160),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.starRating,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                context.l10n.ratingReviewsLabel(state.avgRating.toStringAsFixed(1), '${state.reviewsCount}'),
                                style: AppTextStyles.bodySm.copyWith(
                                  color: cs.onSurface.withAlpha(160),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _StatItem(
                      value: state.totalPatients.toString(),
                      label: context.l10n.statPatients,
                      color: AppColors.primary,
                    ),
                    _StatDivider(),
                    _StatItem(
                      value: '${state.experienceYears}',
                      label: context.l10n.statYearsExp,
                      color: AppColors.secondary,
                    ),
                    _StatDivider(),
                    _StatItem(
                      value: '${state.consultationFee.toStringAsFixed(0)} EGP',
                      label: context.l10n.statFee,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ─── Profile Settings ───
          _SectionHeader(context.l10n.profileSettingsHeader),
          _SettingsTile(
            icon: Icons.person_outline,
            iconBg: AppColors.primary.withAlpha(25),
            iconColor: AppColors.primary,
            title: context.l10n.editProfileTitle,
            subtitle: context.l10n.editProfileDesc,
            onTap: () => context.push('/doctor/profile/edit'),
          ),
          _SettingsTile(
            icon: Icons.calendar_month_outlined,
            iconBg: AppColors.secondary.withAlpha(25),
            iconColor: AppColors.secondary,
            title: context.l10n.manageScheduleTitle,
            subtitle: context.l10n.manageScheduleDesc,
            onTap: () => context.push('/doctor/home/availability'),
          ),
          _SettingsTile(
            icon: Icons.location_on_outlined,
            iconBg: const Color(0xFFFF9800).withAlpha(25),
            iconColor: const Color(0xFFFF9800),
            title: context.l10n.myClinicsTitle,
            subtitle: context.l10n.myClinicsDesc,
            onTap: () => context.push('/doctor/profile/edit'),
          ),
          _SettingsTile(
            icon: Icons.description_outlined,
            iconBg: AppColors.info.withAlpha(25),
            iconColor: AppColors.info,
            title: context.l10n.documentsTitle,
            subtitle: context.l10n.documentsDesc,
            onTap: () => context.push('/doctor/profile/documents'),
          ),

          const SizedBox(height: 8),

          // ─── Account Settings ───
          _SectionHeader(context.l10n.accountSettingsHeader),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            iconBg: AppColors.warning.withAlpha(25),
            iconColor: AppColors.warning,
            title: context.l10n.notificationsTitle,
            subtitle: context.l10n.notificationsDesc,
            onTap: () => context.push('/notifications'),
          ),
          _SettingsTile(
            icon: Icons.account_balance_wallet_outlined,
            iconBg: AppColors.success.withAlpha(25),
            iconColor: AppColors.success,
            title: context.l10n.earningsTitle,
            subtitle: context.l10n.earningsDesc,
            onTap: () => context.push('/doctor/earnings'),
          ),
          _SettingsTile(
            icon: Icons.receipt_long_outlined,
            iconBg: const Color(0xFF9C27B0).withAlpha(25),
            iconColor: const Color(0xFF9C27B0),
            title: context.l10n.transactionHistoryTitle,
            subtitle: context.l10n.transactionHistoryDesc,
            onTap: () => context.push('/doctor/payments/history'),
          ),
          _SettingsTile(
            icon: Icons.language_outlined,
            iconBg: AppColors.primary.withAlpha(25),
            iconColor: AppColors.primary,
            title: context.l10n.appSettingsTitle,
            subtitle: context.l10n.appSettingsDesc,
            onTap: () => context.push('/settings'),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: Text(
                context.l10n.signOutButton,
                style: TextStyle(color: AppColors.error),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _confirmLogout(context),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.signOutButton),
        content: Text(context.l10n.signOutConfirmDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(context.l10n.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await sl<AuthCubit>().logout();
              if (context.mounted) context.go('/login');
            },
            child: Text(
              context.l10n.signOutButton,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: AppTextStyles.labelSm.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withAlpha(30)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMd.copyWith(color: cs.onSurface),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySm.copyWith(
            color: cs.onSurface.withAlpha(160),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: cs.onSurface.withAlpha(120)),
        onTap: onTap,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTextStyles.heading3.copyWith(color: color)),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.bodySm.copyWith(
              color: cs.onSurface.withAlpha(160),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: Theme.of(context).dividerColor,
    );
  }
}
