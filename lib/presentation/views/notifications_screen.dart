import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/colors.dart';
import '../widgets/common/appbar.dart';

class NotificationsScreen extends StatelessWidget {
  static String routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Notifications'),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: kPrimaryColor,
                backgroundImage: AssetImage(kDefaultProfilePic),
              ),

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Notification $index'),
                  Text(
                    '02-02-2025 12:00PM',
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
                  'You have received a new notification.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 14.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
