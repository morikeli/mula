import 'dart:io';

import '../../core/services/user_service.dart';

class ProfileRepository {
  final UserService _service;

  ProfileRepository(this._service);

  Future<void> updateUserProfile({
    String? username,
    String? firstName,
    String? lastName,
    File? profileImage,
  }) async {
    String? photoUrl;

    if (profileImage != null) {
      photoUrl = await _service.uploadProfilePic(profileImage);
    }

    await _service.updateProfile(
      username: username,
      firstName: firstName,
      lastName: lastName,
      photoUrl: photoUrl,
    );
  }
}
