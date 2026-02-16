import '../../core/services/notification_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final NotificationService service;

  NotificationRepository(this.service);

  Stream<List<Notification>> watchNotifications() {
    return service.watchNotifications();
  }

  Future<void> markAsRead(String id) {
    return service.markAsRead(id);
  }

  Stream<int> watchUnreadCount() {
    return service.watchUnreadCount();
  }
}
