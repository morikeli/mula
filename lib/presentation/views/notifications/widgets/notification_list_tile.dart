import 'package:flutter/cupertino.dart' hide Notification;
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/colors.dart';
import '../../../../data/models/notification_model.dart';
import '../../../bloc/notifications_bloc/notifications_bloc.dart';

class NotificationListTiles extends StatelessWidget {
  const NotificationListTiles({
    super.key,
    required this.notification,
  });

  final Notification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<NotificationBloc>().add(
          MarkNotificationRead(notification.id),
        );
      },
    
      leading: CircleAvatar(
        backgroundColor: kPrimaryColor,
        radius: 24.0,
        child: notification.type == NotificationType.moneyReceived
            ? Icon(
                CupertinoIcons.arrow_down_circle,
                // color: kIconDarkColor,
              )
            : Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
      ),
    
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(notification.title),
          Text(
            DateFormat('dd-MM-yyy h:mma').format(notification.date),
            softWrap: true,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12.0),
          ),
        ],
      ),
    
      subtitle: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: Text(
          notification.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontSize: 14.0),
        ),
      ),
    );
  }
}
