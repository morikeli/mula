import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../../bloc/pin_bloc/pin_bloc.dart';
import '../../auth/login_screen.dart';
import 'custom_list_tile.dart';
import 'profile_screen_avatar.dart';
import 'profile_screen_location_widget.dart';
import 'profile_screen_reset_btn.dart';

class ProfileScreenListView extends StatelessWidget {
  const ProfileScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12.0),
      children: [
        // 1. profile picture
        UserAvatarProfileScreen(),

        // 2. username
        SizedBox(height: 8.0),
        UsernameAndLocation(),
        SizedBox(height: 8.0),
        ResetPINButton(),
        SizedBox(height: 8.0),
        CustomListTileWidget(
          leadingIcon: CupertinoIcons.person_add,
          titleText: 'Invite friends',
          subtitleText: 'Get \$5 for every 4 referrals',
          trailingIcon: CupertinoIcons.chevron_right,
        ),

        // 3. Options header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Account & settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 16.0,
              color: kTextSecondaryColor,
            ),
          ),
        ),

        // 4. Account list tile
        CustomListTileWidget(
          leadingIcon: CupertinoIcons.person,
          titleText: 'Account',
          subtitleText: 'User info, saved passwords',
          trailingIcon: CupertinoIcons.chevron_right,
        ),

        // 5. linked banks list tile
        CustomListTileWidget(
          leadingIcon: CupertinoIcons.link,
          titleText: 'Linked banks',
          subtitleText: 'Manage your connected bank accounts',
          trailingIcon: CupertinoIcons.chevron_right,
        ),

        // 6. notifications list tile
        CustomListTileWidget(
          leadingIcon: CupertinoIcons.bell,
          titleText: 'Notifications',
          subtitleText: 'Control alerts and app notifications',
          trailingIcon: CupertinoIcons.chevron_right,
        ),

        // 7. privacy & security list tile
        CustomListTileWidget(
          leadingIcon: CupertinoIcons.shield,
          titleText: 'Privacy & Security',
          subtitleText: 'Manage privacy settings and security',
          trailingIcon: CupertinoIcons.chevron_right,
        ),

        // 8. light/dark mode toggle switch
        ListTile(
          leading: Icon(
            AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                ? CupertinoIcons.moon_stars
                : CupertinoIcons.sun_max,
          ),
          title: Text('Change theme'),
          trailing: Transform.scale(
            scale: .8,
            child: Switch(
              value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
              onChanged: (value) {
                AdaptiveTheme.of(context).setThemeMode(
                  value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light,
                );
              },
            ),
          ),
        ),

        // Danger zone header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Danger zone',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 16.0,
              color: kTextSecondaryColor,
            ),
          ),
        ),

        // 9. Logout button
        ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(LogoutRequested());
            context.read<PinBloc>().add(ResetPinRequested());
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kDangerColor,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.square_arrow_right),
              SizedBox(width: 8.0),
              Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}