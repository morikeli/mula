import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType { moneyReceived, profileUpdated }

class Notification {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime date;
  final bool isRead;

  Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.date,
    required this.isRead,
  });

  factory Notification.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return Notification(
      id: doc.id,
      type: data['type'] == 'money_received'
          ? NotificationType.moneyReceived
          : NotificationType.profileUpdated,
      title: data['title'],
      body: data['body'],
      isRead: data['isRead'] ?? false,
      date: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
