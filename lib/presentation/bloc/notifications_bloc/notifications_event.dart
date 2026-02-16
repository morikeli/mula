part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

final class LoadingNotifications extends NotificationsEvent {}

final class MarkNotificationRead extends NotificationsEvent {
  final String id;
  MarkNotificationRead(this.id);
}

final class LoadUnreadCount extends NotificationsEvent {}
