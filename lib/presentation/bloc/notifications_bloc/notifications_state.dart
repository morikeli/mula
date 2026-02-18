part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationLoaded extends NotificationsState {
  final List<Notification> notifications;
  NotificationLoaded(this.notifications);
}

final class NotificationBadgeState extends NotificationsState {
  final int count;
  NotificationBadgeState(this.count);
}

final class NotificationsUpdated extends NotificationsEvent {
  final List<Notification> notifications;
  NotificationsUpdated(this.notifications);
}

final class NotificationError extends NotificationsState {
  final String message;
  NotificationError(this.message);
}
