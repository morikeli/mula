import 'package:flutter/cupertino.dart' hide Notification;
import 'package:flutter/material.dart' hide Notification;

import '../../../bloc/notifications_bloc/notifications_bloc.dart';
import 'notification_list_tile.dart';

class NotificationsTiles extends StatelessWidget {
  const NotificationsTiles({super.key, required this.state});

  final NotificationLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      itemCount: state.notifications.length,
      itemBuilder: (context, index) {
        final notification = state.notifications[index];

        return NotificationListTiles(notification: notification);
      },
    );
  }
}
