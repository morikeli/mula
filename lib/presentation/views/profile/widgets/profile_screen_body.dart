import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_toasts.dart';
import '../../../../core/utils/loading_indicators.dart';
import '../../../bloc/profile_bloc/profile_bloc.dart';
import 'profile_screen_list_view.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          AppToast.showWarning(context, title: "Profile updated successfully");
        }

        if (state is ProfileFailure) {
          AppToast.showError(context, title: "Failed to update profile");
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
        }

        return ProfileScreenListView();
      },
    );
  }
}