import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class NotificationBellIcon extends StatelessWidget {
  const NotificationBellIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
          icon: Icon(
            CupertinoIcons.bell_fill,
            color: kIconLightColor,
            size: 24.0,
          ),
        ),
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
  }
}
