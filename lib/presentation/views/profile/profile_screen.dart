import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/common/notification_bell_icon.dart';
import 'widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Profile',
        actions: [NotificationBellIcon()],
      ),
      body: ProfileScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(CupertinoIcons.square_pencil, color: kIconLightColor),
      ),
    );
  }
}
