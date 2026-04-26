import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../features/auth/presentation/cubits/auth_cubit.dart';

class DoctorPendingScreen extends StatelessWidget {
  const DoctorPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
            decoration: const BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                // Animated pending indicator
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hourglass_top_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Under Review',
                  style: AppTextStyles.heading1.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your application is pending admin approval',
                  style: AppTextStyles.bodyMd.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Timeline steps
                  _buildStep(
                    icon: Icons.check_circle_rounded,
                    title: 'Account Created',
                    subtitle: 'Your doctor account has been created',
                    isDone: true,
                  ),
                  _buildConnector(isDone: true),
                  _buildStep(
                    icon: Icons.upload_file_rounded,
                    title: 'Documents Submitted',
                    subtitle: 'Your credentials are being reviewed',
                    isDone: true,
                  ),
                  _buildConnector(isDone: false),
                  _buildStep(
                    icon: Icons.verified_rounded,
                    title: 'Admin Verification',
                    subtitle: 'Usually takes 1–2 business days',
                    isDone: false,
                  ),
                  _buildConnector(isDone: false),
                  _buildStep(
                    icon: Icons.rocket_launch_rounded,
                    title: 'Start Practicing',
                    subtitle: 'Welcome aboard, Doctor!',
                    isDone: false,
                  ),

                  const Spacer(),

                  // Info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_outlined,
                            color: AppColors.secondary, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'We\'ll notify you once your account is approved. '
                            'You can safely close the app and come back.',
                            style: AppTextStyles.bodySm
                                .copyWith(color: AppColors.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await sl<AuthCubit>().logout();
                        if (context.mounted) context.go('/login');
                      },
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: const Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDone,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isDone ? AppColors.primary : AppColors.surface,
            shape: BoxShape.circle,
            border: isDone
                ? null
                : Border.all(color: AppColors.divider, width: 1.5),
          ),
          child: Icon(
            icon,
            size: 22,
            color: isDone ? Colors.white : AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.label.copyWith(
                  color: isDone ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              Text(
                subtitle,
                style:
                    AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnector({required bool isDone}) {
    return Padding(
      padding: const EdgeInsets.only(left: 21),
      child: Container(
        width: 2,
        height: 24,
        color: isDone ? AppColors.primary : AppColors.divider,
      ),
    );
  }
}
