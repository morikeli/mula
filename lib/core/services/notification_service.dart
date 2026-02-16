import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  NotificationService(this.firestore, this.auth);

  String get uid => auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> _ref() =>
      firestore.collection('users').doc(uid).collection('notifications');

  Future<void> createNotification({
    required String targetUid,
    required String type,
    required String title,
    required String body,
    Map<String, dynamic>? metadata,
  }) async {
    await firestore
        .collection('users')
        .doc(targetUid)
        .collection('notifications')
        .add({
          'type': type,
          'title': title,
          'body': body,
          'timestamp': FieldValue.serverTimestamp(),
          'isRead': false,
          'metadata': metadata ?? {},
        });
  }

  Stream<List<Notification>> watchNotifications() {
    return _ref()
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => Notification.fromFirestore(d)).toList(),
        );
  }

  Future<void> markAsRead(String id) async {
    await _ref().doc(id).update({'isRead': true});
  }

  Stream<int> watchUnreadCount() {
    final uid = auth.currentUser!.uid;

    return firestore
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snap) => snap.docs.length);
  }
}
