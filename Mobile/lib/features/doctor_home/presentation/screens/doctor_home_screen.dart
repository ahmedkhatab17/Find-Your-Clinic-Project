import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/di/service_locator.dart';
import '../../../home_highlights/domain/entities/tour_step.dart';
import '../../../home_highlights/presentation/cubits/home_highlights_cubit.dart';
import '../../../home_highlights/presentation/widgets/home_highlights_overlay.dart';
import '../../../notifications/presentation/cubits/notification_badge_cubit.dart';
import '../../../notifications/presentation/cubits/notification_badge_state.dart';
import '../cubits/doctor_home_cubit.dart';
import '../cubits/doctor_home_state.dart';
import '../widgets/next_appointment_card.dart';
import '../widgets/performance_card.dart';
import '../widgets/schedule_item_card.dart';
import '../widgets/stat_card.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final _headerKey = GlobalKey();
  final _quickStatsKey = GlobalKey();
  final _performanceKey = GlobalKey();
  final _scheduleKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<DoctorHomeCubit>().loadDashboard();
  }

  List<TourStep> _buildSteps() {
    return [
      TourStep(
        targetKey: _headerKey,
        title: context.l10n.tourDashboardTitle,
        description:
            context.l10n.tourDashboardDesc,
        cutoutPadding: EdgeInsets.zero,
        cutoutRadius: 0,
      ),
      TourStep(
        targetKey: _quickStatsKey,
        title: context.l10n.tourQuickStatsTitle,
        description:
            context.l10n.tourQuickStatsDesc,
      ),
      TourStep(
        targetKey: _performanceKey,
        title: context.l10n.tourPerformanceTitle,
        description:
            context.l10n.tourPerformanceDesc,
      ),
      TourStep(
        targetKey: _scheduleKey,
        title: context.l10n.tourScheduleTitle,
        description:
            context.l10n.tourScheduleDesc,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => sl<HomeHighlightsCubit>(),
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
              builder: (context, state) => switch (state) {
                DoctorHomeInitial() || DoctorHomeLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                DoctorHomeError(:final message) => ErrorView(
                  message: message,
                  onRetry: () =>
                      context.read<DoctorHomeCubit>().loadDashboard(),
                ),
                DoctorHomeLoaded(:final dashboard) => RefreshIndicator(
                  onRefresh: () =>
                      context.read<DoctorHomeCubit>().loadDashboard(),
                  child: CustomScrollView(
                    slivers: [
                      // ─── App Bar ───
                      SliverAppBar(
                        expandedHeight: 120,
                        floating: true,
                        pinned: true,
                        backgroundColor: AppColors.primary,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            key: _headerKey,
                            decoration: BoxDecoration(
                              gradient: isDark
                                  ? AppTheme.headerGradientDark
                                  : AppTheme.headerGradient,
                            ),
                            child: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  12,
                                  20,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                context.l10n.dashboardTitle,
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                DateFormat(
                                                  'EEEE, MMMM d',
                                                  context.l10n.localeName,
                                                ).format(DateTime.now()),
                                                style: AppTextStyles.bodyMd
                                                    .copyWith(
                                                      color: Colors.white70,
                                                    ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${_getGreeting(context)}, ${dashboard.doctorName} 👋',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BlocBuilder<
                                          NotificationBadgeCubit,
                                          NotificationBadgeState
                                        >(
                                          builder: (context, badgeState) {
                                            final count =
                                                badgeState
                                                    is NotificationBadgeLoaded
                                                ? badgeState.unreadCount
                                                : 0;
                                            return IconButton(
                                              onPressed: () => context
                                                  .pushNamed('notifications')
                                                  .then((_) {
                                                    if (context.mounted) {
                                                      context
                                                          .read<
                                                            NotificationBadgeCubit
                                                          >()
                                                          .loadUnreadCount();
                                                    }
                                                  }),
                                              icon: Badge(
                                                isLabelVisible: count > 0,
                                                label: Text(
                                                  count > 9
                                                      ? '9+'
                                                      : count.toString(),
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withAlpha(30),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .notifications_outlined,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ─── Quick Stats ───
                      SliverToBoxAdapter(
                        child: Padding(
                          key: _quickStatsKey,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quick Stats',
                                style: AppTextStyles.heading3,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: StatCard(
                                      label: context.l10n.statTotal,
                                      value:
                                          '${dashboard.quickStats.totalToday}',
                                      icon: Icons.people,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: StatCard(
                                      label: context.l10n.statCompleted,
                                      value:
                                          '${dashboard.quickStats.completed}',
                                      icon: Icons.check_circle,
                                      color: AppColors.success,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: StatCard(
                                      label: context.l10n.statPending,
                                      value: '${dashboard.quickStats.pending}',
                                      icon: Icons.schedule,
                                      color: AppColors.warning,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: StatCard(
                                      label: context.l10n.statCancelled,
                                      value:
                                          '${dashboard.quickStats.cancelled}',
                                      icon: Icons.cancel,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ─── Next Appointment ───
                      if (dashboard.nextAppointment != null)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.nextAppointmentTitle,
                                  style: AppTextStyles.heading3,
                                ),
                                const SizedBox(height: 12),
                                DoctorNextAppointmentCard(
                                  appointment: dashboard.nextAppointment!,
                                ),
                              ],
                            ),
                          ),
                        ),

                      // ─── Performance Summary + View Insights ───
                      SliverToBoxAdapter(
                        child: Container(
                          key: _performanceKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  24,
                                  20,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.l10n.performanceSummaryTitle,
                                      style: AppTextStyles.heading3,
                                    ),
                                    const SizedBox(height: 12),
                                    PerformanceCard(
                                      performance: dashboard.performance,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 24,
                                ),
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // Navigate to Insights tab (index 3 in doctor shell)
                                    final shell =
                                        StatefulNavigationShell.maybeOf(
                                          context,
                                        );
                                    shell?.goBranch(3);
                                  },
                                  icon: const Icon(Icons.insights),
                                  label: Text(
                                    context.l10n.viewInsightsButton,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ─── Today's Schedule ───
                      SliverToBoxAdapter(
                        child: Padding(
                          key: _scheduleKey,
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.l10n.todaysScheduleTitle,
                                style: AppTextStyles.heading3,
                              ),
                              TextButton.icon(
                                onPressed: () =>
                                    context.push('/doctor/home/availability'),
                                icon: const Icon(Icons.edit_calendar, size: 18),
                                label: Text(context.l10n.manageButton),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (dashboard.todaySchedule.isEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: EmptyStateView(
                              icon: Icons.event_available,
                              title: context.l10n.noAppointmentsTodayTitle,
                              subtitle:
                                  context.l10n.noAppointmentsTodayDesc,
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverList.separated(
                            itemCount: dashboard.todaySchedule.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return ScheduleItemCard(
                                item: dashboard.todaySchedule[index],
                              );
                            },
                          ),
                        ),

                      const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
                    ],
                  ),
                ),
              },
            ),
            BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
              builder: (context, state) {
                if (state is! DoctorHomeLoaded) return const SizedBox.shrink();
                return Positioned.fill(
                  child: HomeHighlightsOverlay(steps: _buildSteps()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.l10n.greetingMorning;
    if (hour < 17) return context.l10n.greetingAfternoon;
    return context.l10n.greetingEvening;
  }
}
