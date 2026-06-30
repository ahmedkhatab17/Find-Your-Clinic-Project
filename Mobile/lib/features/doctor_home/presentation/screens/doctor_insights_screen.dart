import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubits/insights_cubit.dart';
import '../cubits/insights_state.dart';
import '../widgets/schedule_item_card.dart';
import '../widgets/stat_card.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../payment/presentation/cubits/doctor_earnings_cubit.dart';

class DoctorInsightsScreen extends StatelessWidget {
  const DoctorInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.insightsTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? AppTheme.headerGradientDark
                : AppTheme.headerGradient,
          ),
        ),
      ),
      body: BlocBuilder<InsightsCubit, InsightsState>(
        builder: (context, state) {
          if (state is InsightsLoading || state is InsightsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InsightsError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<InsightsCubit>().loadInsights(),
            );
          }

          if (state is! InsightsLoaded) return const SizedBox.shrink();

          final dashboard = state.dashboard;
          final stats = dashboard.quickStats;
          final overall = dashboard.overallStats;
          final perf = dashboard.performance;

          return RefreshIndicator(
            onRefresh: () => context.read<InsightsCubit>().loadInsights(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(context.l10n.insightsOverall, style: AppTextStyles.heading3),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.72,
                    children: [
                      StatCard(
                        label: context.l10n.statTotal,
                        value: '${overall.total}',
                        icon: Icons.assessment_outlined,
                        color: AppColors.primary,
                      ),
                      StatCard(
                        label: context.l10n.statDone,
                        value: '${overall.completed}',
                        icon: Icons.check_circle_outline,
                        color: AppColors.success,
                      ),
                      StatCard(
                        label: context.l10n.statPending,
                        value: '${overall.pending}',
                        icon: Icons.schedule,
                        color: AppColors.warning,
                      ),
                      StatCard(
                        label: context.l10n.statCancelled,
                        value: '${overall.cancelled}',
                        icon: Icons.cancel_outlined,
                        color: AppColors.error,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      context.l10n.insightsTodaysOverview,
                      style: AppTextStyles.heading3,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.72,
                    children: [
                      StatCard(
                        label: context.l10n.statTotal,
                        value: '${stats.totalToday}',
                        icon: Icons.today,
                        color: AppColors.primary,
                      ),
                      StatCard(
                        label: context.l10n.statDone,
                        value: '${stats.completed}',
                        icon: Icons.check_circle_outline,
                        color: AppColors.success,
                      ),
                      StatCard(
                        label: context.l10n.statPending,
                        value: '${stats.pending}',
                        icon: Icons.schedule,
                        color: AppColors.warning,
                      ),
                      StatCard(
                        label: context.l10n.statCancelled,
                        value: '${stats.cancelled}',
                        icon: Icons.cancel_outlined,
                        color: AppColors.error,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      context.l10n.insightsOverallPerformance,
                      style: AppTextStyles.heading3,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9,
                    children: [
                      StatCard(
                        label: context.l10n.statPatients,
                        value: '${perf.totalPatients}',
                        icon: Icons.people_outline,
                        color: AppColors.primary,
                      ),
                      StatCard(
                        label: context.l10n.statReviews,
                        value: '${perf.totalReviews}',
                        icon: Icons.rate_review_outlined,
                        color: AppColors.secondary,
                      ),
                      StatCard(
                        label: context.l10n.statRating,
                        value: perf.averageRating.toStringAsFixed(1),
                        icon: Icons.star_outline,
                        color: AppColors.starRating,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<DoctorEarningsCubit, DoctorEarningsState>(
                    builder: (context, earningsState) {
                      if (earningsState is DoctorEarningsLoaded) {
                        final earnings = earningsState.earnings;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                              child: Text(
                                context.l10n.insightsFinancialOverview,
                                style: AppTextStyles.heading3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StatCard(
                                      label: context.l10n.insightsAvailableBalance,
                                      value:
                                          '${earnings.pendingBalance.toStringAsFixed(0)} EGP',
                                      icon:
                                          Icons.account_balance_wallet_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: StatCard(
                                      label: context.l10n.insightsTotalEarned,
                                      value:
                                          '${earnings.totalEarnings.toStringAsFixed(0)} EGP',
                                      icon: Icons.trending_up_outlined,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      context.l10n.todaysScheduleTitle,
                      style: AppTextStyles.heading3,
                    ),
                  ),
                ),
                if (dashboard.todaySchedule.isEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: EmptyStateView(
                        icon: Icons.event_available,
                        title: context.l10n.noAppointmentsTodayTitle,
                        subtitle: context.l10n.noAppointmentsTodayClear,
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    sliver: SliverList.separated(
                      itemCount: dashboard.todaySchedule.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 10),
                      itemBuilder: (context, i) =>
                          ScheduleItemCard(item: dashboard.todaySchedule[i]),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
