import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/helpers/image_picker.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/app_toasts.dart';
import '../../../bloc/profile_bloc/profile_bloc.dart';

class UserAvatarProfileScreen extends StatelessWidget {
  const UserAvatarProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * .16,
            backgroundImage: AssetImage(kMaleProfilePicture),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton.filled(
              onPressed: () async {
                final image = await pickImage();
                if (context.mounted) {
                  // validate if user has selected an image
                  if (image == null) {
                    AppToast.showError(context, title: "No image selected");
                    return;
                  }

                  context.read<ProfileBloc>().add(
                    UpdateProfileRequested(profileImage: image),
                  );
                }
              },
              icon: Icon(
                CupertinoIcons.camera,
                color: kIconLightColor,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
