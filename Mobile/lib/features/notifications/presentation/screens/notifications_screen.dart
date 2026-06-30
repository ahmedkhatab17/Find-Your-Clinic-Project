import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../accessibility/domain/entities/screen_context.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_cubit.dart';
import '../../domain/entities/notification_entity.dart';
import '../cubits/notifications_cubit.dart';
import '../cubits/notifications_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const _screenContext = ScreenContext(screen: PatientScreen.notifications);

  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().loadNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<VoiceAssistantCubit>().setScreenContext(
            _screenContext,
            summary: _buildScreenSummary,
            itemSelector: _itemSelector,
          );
    });
  }

  String _buildScreenSummary() {
    final state = context.read<NotificationsCubit>().state;
    if (state is NotificationsLoaded) {
      if (state.notifications.isEmpty) return context.l10n.noNotificationsTitle;
      final unread = state.notifications.where((n) => !n.isRead).length;
      final buffer = StringBuffer('You have ${state.notifications.length} notifications, $unread unread. ');
      final readN = state.notifications.length > 3 ? 3 : state.notifications.length;
      for (var i = 0; i < readN; i++) {
        final n = state.notifications[i];
        buffer.write('${i + 1}: ${n.title}. ');
      }
      return buffer.toString();
    }
    return context.l10n.notificationsTitle;
  }

  bool _itemSelector(int index) {
    final state = context.read<NotificationsCubit>().state;
    if (state is! NotificationsLoaded) return false;
    if (index < 0 || index >= state.notifications.length) return false;
    final notif = state.notifications[index];
    if (!notif.isRead) {
      context.read<NotificationsCubit>().markAsRead(notif.id);
    }
    _navigate(context, notif);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final hasUnread = state is NotificationsLoaded &&
            state.notifications.any((n) => !n.isRead);

        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.notificationsTitle),
            actions: [
              if (hasUnread)
                TextButton(
                  onPressed: () =>
                      context.read<NotificationsCubit>().markAllAsRead(),
                  child: Text(context.l10n.markAllRead),
                ),
            ],
          ),
          body: switch (state) {
            NotificationsInitial() || NotificationsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            NotificationsError(:final message) => ErrorView(
                message: message,
                onRetry: () =>
                    context.read<NotificationsCubit>().loadNotifications(),
              ),
            NotificationsLoaded(:final notifications) => notifications.isEmpty
                ? EmptyStateView(
                    icon: Icons.notifications_none,
                    title: context.l10n.noNotificationsTitle,
                    subtitle: context.l10n.noNotificationsDesc,
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        context.read<NotificationsCubit>().loadNotifications(),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final notif = notifications[index];
                        return _NotificationCard(
                          notification: notif,
                          onTap: () async {
                            if (!notif.isRead) {
                              context
                                  .read<NotificationsCubit>()
                                  .markAsRead(notif.id);
                            }
                            if (context.mounted) _navigate(context, notif);
                          },
                        );
                      },
                    ),
                  ),
          },
        );
      },
    );
  }

  Future<void> _navigate(BuildContext context, AppNotification notif) async {
    final type = notif.type ?? '';
    final ref = notif.referenceId;
    if (type.startsWith('appointment_') && ref != null) {
      final role = await sl<TokenStorage>().getUserRole();
      if (!context.mounted) return;
      final isDoctor = role == 'Doctor';
      context.push('/appointment/$ref${isDoctor ? '?doctor=true' : ''}');
    } else if (type == 'new_message' && ref != null) {
      context.push('/chat/$ref');
    }
  }
}

class _NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  IconData get _icon {
    final t = notification.type ?? '';
    if (t.startsWith('appointment_')) return Icons.calendar_today;
    if (t == 'new_message') return Icons.chat_bubble;
    if (t == 'new_review') return Icons.star;
    if (t.startsWith('doctor_')) return Icons.verified_user;
    return Icons.notifications;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MergeSemantics(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? (isDark ? AppColors.darkSurface : AppColors.surface)
              : (isDark
                  ? AppColors.primary.withAlpha(20)
                  : AppColors.primary.withAlpha(8)),
          borderRadius: BorderRadius.circular(14),
          border: notification.isRead
              ? null
              : Border.all(color: AppColors.primary.withAlpha(40)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.translateNotificationTitle(notification.type) ?? notification.title,
                    style: notification.isRead
                        ? AppTextStyles.label
                        : AppTextStyles.label
                            .copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.translateNotificationBody(notification.type) ?? notification.body,
                    style: AppTextStyles.bodySm
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formatRelativeTime(notification.createdAt, context),
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textHint),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }
}
