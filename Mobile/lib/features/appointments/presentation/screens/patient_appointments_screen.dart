import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../accessibility/domain/entities/screen_context.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_cubit.dart';
import '../../domain/entities/appointment_entity.dart';
import '../cubits/appointment_cubit.dart';
import '../cubits/appointment_state.dart';
import '../widgets/appointment_card.dart';
import '../widgets/cancel_appointment_sheet.dart';

/// Patient appointments list with Upcoming / Completed / Cancelled tabs.
class PatientAppointmentsScreen extends StatefulWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  State<PatientAppointmentsScreen> createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _screenContext =
      ScreenContext(screen: PatientScreen.appointments);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<AppointmentCubit>().loadPatientAppointments();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Silent context registration — speech only on user request.
      context.read<VoiceAssistantCubit>().setScreenContext(
            _screenContext,
            summary: _buildScreenSummary,
            itemSelector: _itemSelector,
          );
    });
  }

  String _buildScreenSummary() {
    final state = context.read<AppointmentCubit>().state;
    if (state is AppointmentListLoaded) {
      return context.l10n.myAppointmentsSummary(
        state.upcoming.length,
        state.completed.length,
        state.cancelled.length,
      );
    }
    return context.l10n.myAppointmentsLoading;
  }

  bool _itemSelector(int index) {
    final state = context.read<AppointmentCubit>().state;
    if (state is! AppointmentListLoaded) return false;

    // Which list are we looking at? The selected tab.
    final list = switch (_tabController.index) {
      0 => state.upcoming,
      1 => state.completed,
      _ => state.cancelled,
    };

    if (index < 0 || index >= list.length) return false;

    final apt = list[index];
    context.push('/appointment/${apt.id}');
    return true;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(
            context.l10n.appointments,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: theme.brightness == Brightness.dark
                ? AppTheme.headerGradientDark
                : AppTheme.headerGradient,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Semantics(
            label: context.l10n.appointments, // A general label for the tab bar
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              labelStyle: AppTextStyles.label,
              unselectedLabelStyle: AppTextStyles.bodyMd,
              tabs: [
                Tab(text: context.l10n.tabUpcoming),
                Tab(text: context.l10n.tabCompleted),
                Tab(text: context.l10n.tabCancelled),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.success,
              ),
            );
          }
          if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AppointmentLoading || state is AppointmentActionInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AppointmentListLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildTab(context, state.upcoming, 'upcoming'),
                _buildTab(context, state.completed, 'completed'),
                _buildTab(context, state.cancelled, 'cancelled'),
              ],
            );
          }

          if (state is AppointmentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(state.message, style: AppTextStyles.bodyMd),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AppointmentCubit>().loadPatientAppointments(),
                    child: Text(context.l10n.retryButton),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    List<AppointmentEntity> appointments,
    String type,
  ) {
    if (appointments.isEmpty) {
      return _buildEmptyState(context, type);
    }

    return RefreshIndicator(
      onRefresh: () =>
          context.read<AppointmentCubit>().loadPatientAppointments(),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 80),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final apt = appointments[index];
          return AppointmentCard(
            appointment: apt,
            onTap: () => context.push(
              '/appointment/${apt.id}',
            ),
            onCancel: (apt.effectiveStatus == AppointmentStatus.scheduled ||
                    apt.effectiveStatus == AppointmentStatus.confirmed)
                ? () => CancelAppointmentSheet.show(
                      context,
                      personName: apt.relatedPersonName,
                      onCancel: () => context
                          .read<AppointmentCubit>()
                          .cancelAppointment(apt.id),
                    )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String type) {
    final theme = Theme.of(context);
    final (icon, title, subtitle) = switch (type) {
      'upcoming' => (
          Icons.calendar_today_outlined,
          context.l10n.noUpcomingAppointmentsTitle,
          context.l10n.noUpcomingAppointmentsDesc,
        ),
      'completed' => (
          Icons.check_circle_outline,
          context.l10n.noCompletedAppointmentsTitle,
          context.l10n.noCompletedAppointmentsDesc,
        ),
      _ => (
          Icons.cancel_outlined,
          context.l10n.noCancelledAppointmentsTitle,
          context.l10n.noCancelledAppointmentsDesc,
        ),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 72,
                color: theme.brightness == Brightness.dark
                    ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
                    : AppColors.textHint),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.heading3.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMd.copyWith(
                color: theme.brightness == Brightness.dark
                    ? theme.colorScheme.onSurfaceVariant
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (type == 'upcoming') ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => context.push('/search'),
                icon: const Icon(Icons.search),
                label: Text(context.l10n.findADoctor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
