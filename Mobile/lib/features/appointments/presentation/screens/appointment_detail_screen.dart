import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../chat/domain/usecases/start_conversation_usecase.dart';
import '../../domain/entities/appointment_entity.dart';
import '../cubits/appointment_cubit.dart';
import '../cubits/appointment_state.dart';
import '../cubits/patient_card_cubit.dart';
import '../../../accessibility/domain/entities/screen_context.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_cubit.dart';
import '../widgets/cancel_appointment_sheet.dart';
import '../widgets/patient_info_card.dart';
import '../../../../core/extensions/appointment_status_l10n_extension.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final String appointmentId;
  final bool isDoctorView;

  const AppointmentDetailScreen({
    super.key,
    required this.appointmentId,
    this.isDoctorView = false,
  });

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  static const _screenContext =
      ScreenContext(screen: PatientScreen.appointmentDetail);

  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().loadAppointmentDetail(
          widget.appointmentId,
          isDoctorView: widget.isDoctorView,
        );

    if (!widget.isDoctorView) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<VoiceAssistantCubit>().setScreenContext(
              _screenContext,
              summary: _buildScreenSummary,
            );
      });
    }
  }

  String _buildScreenSummary() {
    final state = context.read<AppointmentCubit>().state;
    if (state is AppointmentDetailLoaded) {
      final apt = state.appointment;
      final date = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode).format(apt.scheduledAt);
      final time = DateFormat.jm(Localizations.localeOf(context).languageCode).format(apt.scheduledAt);
      final label = apt.effectiveStatus.getLocalizedLabel(context, widget.isDoctorView);
      return 'Appointment with ${apt.relatedPersonName} on $date at $time. Status: $label.';
    }
    return 'Loading appointment details...';
  }

  @override
  Widget build(BuildContext context) {
    final body = Scaffold(
      appBar: AppBar(
        title: Text(widget.isDoctorView ? context.l10n.appointmentDetailsTitle : context.l10n.myAppointmentTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.success),
            );
            context.pop(true);
          }
          if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          if (state is AppointmentLoading ||
              state is AppointmentActionInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AppointmentDetailLoaded) {
            if (widget.isDoctorView) {
              // Trigger patient card load on first render
              final cubit = context.read<PatientCardCubit>();
              if (cubit.state is PatientCardInitial) {
                cubit.load(state.appointment.patientId);
              }
            }
            return _AppointmentDetailBody(
              apt: state.appointment,
              isDoctorView: widget.isDoctorView,
            );
          }
          if (state is AppointmentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<AppointmentCubit>()
                        .loadAppointmentDetail(widget.appointmentId),
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

    if (!widget.isDoctorView) return body;

    return BlocProvider(
      create: (_) => sl<PatientCardCubit>(),
      child: body,
    );
  }
}

class _AppointmentDetailBody extends StatelessWidget {
  final AppointmentEntity apt;
  final bool isDoctorView;

  const _AppointmentDetailBody({
    required this.apt,
    required this.isDoctorView,
  });

  @override
  Widget build(BuildContext context) {
    final endTime = apt.scheduledAt.add(const Duration(minutes: 30));

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Doctor action banner (Accept/Decline/Complete)
          if (isDoctorView) ...[
            _ActionBanner(apt: apt),
            const SizedBox(height: 12),
          ],

          // 2. Info card (Doctor or Patient)
          _InfoCard(
            child: Row(
              children: [
                _Avatar(
                  name: apt.relatedPersonName,
                  imageUrl: apt.relatedPersonImageUrl,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(apt.relatedPersonName,
                          style: AppTextStyles.heading3),
                      if (apt.specialty != null)
                        Text(
                          apt.specialty!,
                          style: AppTextStyles.bodySm
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      if (isDoctorView)
                        Text(
                          '${context.l10n.bookingRefPrefix}${apt.id.substring(0, 8).toUpperCase()}',
                          style: AppTextStyles.bodySm
                              .copyWith(color: AppColors.textSecondary),
                        ),
                    ],
                  ),
                ),
                _StatusBadge(status: apt.effectiveStatus, isDoctor: isDoctorView),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 3. Large date/time block
          _InfoCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.calendar_today,
                      color: AppColors.primary, size: 32),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, MMM d', Localizations.localeOf(context).languageCode).format(apt.scheduledAt),
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${DateFormat.jm(Localizations.localeOf(context).languageCode).format(apt.scheduledAt)} — ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(endTime)}',
                      style: AppTextStyles.bodyMd
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 4. Details
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.detailsTitle, style: AppTextStyles.label),
                const SizedBox(height: 12),
                if (apt.locationName != null)
                  _InfoRow(Icons.location_on_outlined, context.l10n.locationTitle,
                      apt.locationName!),
                _InfoRow(
                    Icons.confirmation_number_outlined,
                    context.l10n.bookingRefTitle,
                    '#${apt.id.substring(0, 8).toUpperCase()}'),
                _InfoRow(Icons.event_note_outlined, context.l10n.bookedOnTitle,
                    DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(apt.createdAt)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 5. Patient info card (doctor only)
          if (isDoctorView) ...[
            const SizedBox(height: 16),
            PatientInfoCard(patientId: apt.patientId),
            const SizedBox(height: 4),
          ],

          // 6. Actions
          if (!isDoctorView)
            OutlinedButton.icon(
              icon: const Icon(Icons.person_outline),
              label: Text(context.l10n.viewDoctorProfileButton),
              onPressed: () => context.push(
                '/doctor-details/${apt.doctorUserId}',
                extra: {
                  'canReview': apt.effectiveStatus == AppointmentStatus.completed,
                  'canMessage': apt.effectiveStatus != AppointmentStatus.cancelled,
                },
              ),
            ),

          if (apt.effectiveStatus != AppointmentStatus.completed &&
              apt.effectiveStatus != AppointmentStatus.cancelled) ...[
            if (!isDoctorView) const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _startConversation(
                context,
                isDoctorView ? apt.patientId : apt.doctorUserId,
              ),
              icon: const Icon(Icons.chat_bubble_outline),
              label: Text(isDoctorView ? context.l10n.messagePatientButton : context.l10n.messageDoctorButton),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => CancelAppointmentSheet.show(
                context,
                personName: apt.relatedPersonName,
                onCancel: () => context
                    .read<AppointmentCubit>()
                    .cancelAppointment(apt.id),
              ),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: Text(context.l10n.cancelAppointmentButton),
            ),
          ],
        ],
      ),
    );
  }

  void _startConversation(BuildContext context, String userId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final result = await sl<StartConversationUseCase>()(userId);
      if (context.mounted) Navigator.pop(context);
      switch (result) {
        case Success(:final data):
          if (context.mounted) context.push('/chat/${data.id}');
        case Error(:final failure):
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(failure.message),
                  backgroundColor: AppColors.error),
            );
          }
      }
    } catch (_) {
      if (context.mounted) Navigator.pop(context);
    }
  }
}

class _ActionBanner extends StatelessWidget {
  final AppointmentEntity apt;
  const _ActionBanner({required this.apt});

  @override
  Widget build(BuildContext context) {
    // Awaiting doctor approval — applies to both online (scheduled) and
    // cash (pendingPayment) bookings the doctor hasn't actioned yet.
    if (apt.effectiveStatus == AppointmentStatus.scheduled ||
        apt.effectiveStatus == AppointmentStatus.pendingPayment) {
      final isCashPending =
          apt.effectiveStatus == AppointmentStatus.pendingPayment;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.warning.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.warning.withAlpha(80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.pending_actions,
                    color: AppColors.warning, size: 20),
                const SizedBox(width: 8),
                Text(
                  isCashPending
                      ? context.l10n.newCashBookingActionReq
                      : context.l10n.actionRequired,
                  style: AppTextStyles.label
                      .copyWith(color: AppColors.warning),
                ),
              ],
            ),
            if (isCashPending) ...[
              const SizedBox(height: 6),
              Text(
                context.l10n.cashBookingDoctorDesc,
                style: AppTextStyles.bodySm
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: AppColors.success),
                    onPressed: () => context
                        .read<AppointmentCubit>()
                        .confirmAppointment(apt.id),
                    child: Text(isCashPending ? context.l10n.approveButton : context.l10n.acceptButton),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    onPressed: () => context
                        .read<AppointmentCubit>()
                        .cancelAppointment(apt.id),
                    child: Text(isCashPending ? context.l10n.rejectButton : context.l10n.declineButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    if (apt.effectiveStatus == AppointmentStatus.confirmed ||
        apt.effectiveStatus == AppointmentStatus.completed) {
      return Column(
        children: [
          if (apt.needsCashPayment) _MarkAsPaidBanner(apt: apt),
          if (apt.effectiveStatus == AppointmentStatus.confirmed)
            _ConfirmedBanner(apt: apt),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class _ConfirmedBanner extends StatelessWidget {
  final AppointmentEntity apt;
  const _ConfirmedBanner({required this.apt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.success.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline,
                  color: AppColors.success, size: 20),
              const SizedBox(width: 8),
              Text(context.l10n.appointmentConfirmedTitle,
                  style: AppTextStyles.label
                      .copyWith(color: AppColors.success)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary),
              onPressed: () => context
                  .read<AppointmentCubit>()
                  .completeAppointment(apt.id),
              child: Text(context.l10n.markAsCompletedButton),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarkAsPaidBanner extends StatelessWidget {
  final AppointmentEntity apt;
  const _MarkAsPaidBanner({required this.apt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.payments_outlined,
                  color: AppColors.info, size: 20),
              const SizedBox(width: 8),
              Text(context.l10n.cashPaymentPendingTitle,
                  style: AppTextStyles.label
                      .copyWith(color: AppColors.info)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.cashPaymentPendingDesc,
            style: AppTextStyles.bodySm
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.check_rounded),
              label: Text(context.l10n.markAsPaidButton),
              style: FilledButton.styleFrom(backgroundColor: AppColors.info),
              onPressed: () => _confirmMarkAsPaid(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmMarkAsPaid(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.markAsPaidDialogTitle),
        content: Text(
          context.l10n.markAsPaidDialogDesc,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.cancelButton),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.l10n.confirmButton),
          ),
        ],
      ),
    );
    if (!context.mounted) return;
    if (confirm ?? false) {
      context.read<AppointmentCubit>().markCashAppointmentAsPaid(apt.id);
    }
  }
}

// ─────────────────────────────────────────────
// Shared small widgets
// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final Widget child;
  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withAlpha(40)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 4,
              offset: const Offset(0, 1)),
        ],
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 1),
                Text(value,
                    style: AppTextStyles.bodyMd
                        .copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AppointmentStatus status;
  final bool isDoctor;
  const _StatusBadge({required this.status, required this.isDoctor});

  Color get _color => switch (status) {
        AppointmentStatus.scheduled => AppColors.warning,
        AppointmentStatus.confirmed => AppColors.success,
        AppointmentStatus.cancelled => AppColors.error,
        AppointmentStatus.completed => AppColors.textSecondary,
        AppointmentStatus.pendingPayment => AppColors.info,
      };

  String _getLabel(BuildContext context) => status.getLocalizedLabel(context, isDoctor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withAlpha(100)),
      ),
      child: Text(
        _getLabel(context),
        style: AppTextStyles.labelSm.copyWith(
          color: _color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  const _Avatar({required this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    const colors = [
      AppColors.primary,
      AppColors.secondary,
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
      Color(0xFF06B6D4),
    ];
    final bg = colors[initial.codeUnitAt(0) % colors.length];

    return UserAvatar(
      radius: 26,
      imageUrl: imageUrl,
      fullName: name,
      backgroundColor: bg,
      textStyle: AppTextStyles.heading3.copyWith(color: Colors.white),
    );
  }
}
