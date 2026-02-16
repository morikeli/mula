import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/notifications_bloc/notifications_bloc.dart';
import '../../widgets/common/appbar.dart';
import 'widgets/notifications_tile.dart';

class NotificationsScreen extends StatelessWidget {
  static String routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Notifications'),
      body: BlocBuilder<NotificationBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }

          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return ErrorWidget();
            }

            return NotificationsTiles(state: state);
          }

          return ErrorWidget();
        },
      ),
    );
  }
}


class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.32),
        Icon(
          CupertinoIcons.bell_slash_fill,
          size: 48.0,
          color: kIconLightColor,
        ),
        SizedBox(height: 12.0),
        Center(child: Text('No notifications yet')),
      ],
    );
  }
}
