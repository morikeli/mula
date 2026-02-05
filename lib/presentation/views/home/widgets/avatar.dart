import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../../widgets/common/notification_bell_icon.dart';

class UserAvatarAndGreetings extends StatelessWidget {
  const UserAvatarAndGreetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: MediaQuery.of(context).size.width * .06,
          backgroundImage: AssetImage(kMaleProfilePicture),
        ),
        minLeadingWidth: 2.0,

        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String name = 'User';
            if (state is IsAuthenticated) {
              final user = state.user;
              name = "${user.firstName ?? user.email.split('@').first} ${user.lastName ?? ''}";
            }
            return Text(
              'Hello $name,',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 16.0),
            );
          },
        ),

        subtitle: Text(
          'Welcome back!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: NotificationBellIcon(),
      ),
    );
  }
}
