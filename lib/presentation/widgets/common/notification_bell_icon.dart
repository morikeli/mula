import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../../bloc/notifications_bloc/notifications_bloc.dart';

class NotificationBellIcon extends StatelessWidget {
  const NotificationBellIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationsState>(
      builder: (context, state) {
        int unreadNotificationCount = 0;

        if (state is NotificationBadgeState) {
          unreadNotificationCount = state.count;
        }

        return Stack(
          children: [
            IconButton(
              onPressed: () {
                context.read<NotificationBloc>().add(LoadingNotifications());
                Navigator.pushNamed(context, '/notifications');
              },
              icon: Icon(
                CupertinoIcons.bell_fill,
                size: 24.0,
              ),
            ),

            if (unreadNotificationCount > 0)
              Positioned(
                right: 14,
                top: 16,
                child: Badge(
                  backgroundColor: kNotificationBadgeColor,
                  smallSize: 8.0,
                  largeSize: 16.0,
                ),
              ),
          ],
        );
      },
    );
  }
}
