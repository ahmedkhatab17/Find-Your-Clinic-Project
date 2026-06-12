import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../../../features/auth/presentation/cubits/auth_state.dart';

class DoctorPendingScreen extends StatefulWidget {
  const DoctorPendingScreen({super.key});

  @override
  State<DoctorPendingScreen> createState() => _DoctorPendingScreenState();
}

class _DoctorPendingScreenState extends State<DoctorPendingScreen> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>();
    // Check latest doctor status on mount — handles the case where admin
    // rejected the application while the user was looking at this screen.
    _authCubit.getDoctorStatus();
  }

  void _handleState(BuildContext context, AuthState state) {
    if (state is AuthDoctorStatusLoaded) {
      if (state.result.isRejected) {
        context.goNamed(
          RouteNames.doctorRejected,
          extra: state.result.rejectionReason,
        );
      }
      // isApproved is handled by the splash / redirect guard; no action here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: _handleState,
      child: Scaffold(
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
                    alignment: Alignment.center,
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
                    Builder(
                      builder: (context) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Column(
                          children: [
                            _buildStep(
                              icon: Icons.check_circle_rounded,
                              title: 'Account Created',
                              subtitle: 'Your doctor account has been created',
                              isDone: true,
                              isDark: isDark,
                            ),
                            _buildConnector(isDone: true, isDark: isDark),
                            _buildStep(
                              icon: Icons.upload_file_rounded,
                              title: 'Documents Submitted',
                              subtitle: 'Your credentials are being reviewed',
                              isDone: true,
                              isDark: isDark,
                            ),
                            _buildConnector(isDone: false, isDark: isDark),
                            _buildStep(
                              icon: Icons.verified_rounded,
                              title: 'Admin Verification',
                              subtitle: 'Usually takes 1–2 business days',
                              isDone: false,
                              isDark: isDark,
                            ),
                            _buildConnector(isDone: false, isDark: isDark),
                            _buildStep(
                              icon: Icons.rocket_launch_rounded,
                              title: 'Start Practicing',
                              subtitle: 'Welcome aboard, Doctor!',
                              isDone: false,
                              isDark: isDark,
                            ),
                          ],
                        );
                      },
                    ),

                    const Spacer(),

                    // Info card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.secondary,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'We\'ll notify you once your account is approved. '
                              'You can safely close the app and come back.',
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.secondary,
                              ),
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
                          await _authCubit.logout();
                          if (context.mounted) context.go('/login');
                        },
                        icon: const Icon(Icons.logout_rounded, size: 18),
                        label: const Text('Sign Out'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDone,
    required bool isDark,
  }) {
    final circleColor = isDone
        ? AppColors.primary
        : (isDark ? AppColors.darkSurface : AppColors.surface);
    final borderColor = isDark ? AppColors.darkSurfaceAlt : AppColors.divider;
    final iconColor = isDone
        ? Colors.white
        : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary);
    final titleColor = isDone
        ? (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)
        : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary);
    final subtitleColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            border: isDone ? null : Border.all(color: borderColor, width: 1.5),
          ),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.label.copyWith(color: titleColor),
              ),
              Text(
                subtitle,
                style: AppTextStyles.bodySm.copyWith(color: subtitleColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Vertical line connecting timeline steps, aligned with the circle icon.
  Widget _buildConnector({required bool isDone, required bool isDark}) {
    final lineColor = isDone
        ? AppColors.primary
        : (isDark ? AppColors.darkSurfaceAlt : AppColors.divider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        height: 4,
        decoration: BoxDecoration(
          color: lineColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
