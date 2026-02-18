import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/notification_model.dart';
import '../../../data/repositories/notification_repo.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository repository;
  StreamSubscription? _subscription;

  NotificationBloc(this.repository) : super(NotificationsInitial()) {
    on<LoadingNotifications>(_onLoad);
    on<MarkNotificationRead>(_onMarkRead);
    on<NotificationsUpdated>(_onUpdated);
    on<LoadUnreadCount>(_onLoadUnreadCount);

    // on<NotificationError>(_onError);
    add(LoadUnreadCount());
  }

  void _onLoad(LoadingNotifications event, Emitter<NotificationsState> emit) {
    emit(NotificationsLoading());

    _subscription?.cancel();
    _subscription = repository.watchNotifications().listen(
      (notifications) => add(NotificationsUpdated(notifications)),
      onError: (e) => emit(NotificationError(e.toString())),
    );
  }

  Future<void> _onMarkRead(
    MarkNotificationRead event,
    Emitter<NotificationsState> emit,
  ) async {
    await repository.markAsRead(event.id);
  }

  Future<void> _onLoadUnreadCount(
    LoadUnreadCount event,
    Emitter<NotificationsState> emit,
  ) async {
    await emit.forEach<int>(
      repository.watchUnreadCount(),
      onData: (count) => NotificationBadgeState(count),
    );
  }

  // Handlers
  void _onUpdated(
    NotificationsUpdated event,
    Emitter<NotificationsState> emit,
  ) {
    emit(NotificationLoaded(event.notifications));
  }

  // void _onError(NotificationError event, Emitter<NotificationsState> emit) {
  //   emit(NotificationError(event.message));
  // }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
