import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/notification_usecases.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationReadUseCase _markReadUseCase;

  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationReadUseCase markReadUseCase,
  })  : _getNotificationsUseCase = getNotificationsUseCase,
        _markReadUseCase = markReadUseCase,
        super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsLoading());
    final result = await _getNotificationsUseCase();
    switch (result) {
      case Success(:final data):
        emit(NotificationsLoaded(data));
      case Error(:final failure):
        emit(NotificationsError(failure.message));
    }
  }

  Future<void> markAsRead(String id) async {
    final result = await _markReadUseCase(id);
    if (result is Success && state is NotificationsLoaded) {
      final current = (state as NotificationsLoaded).notifications;
      final updated = current.map((n) {
        if (n.id == id) {
          return AppNotification(
            id: n.id,
            title: n.title,
            body: n.body,
            type: n.type,
            isRead: true,
            createdAt: n.createdAt,
          );
        }
        return n;
      }).toList();
      emit(NotificationsLoaded(updated));
    }
  }
}
