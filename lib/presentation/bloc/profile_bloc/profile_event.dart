part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class UpdateProfileRequested extends ProfileEvent {
  final String? username;
  final String? firstName;
  final String? lastName;
  final File? profileImage;

  UpdateProfileRequested({
    this.username,
    this.firstName,
    this.lastName,
    this.profileImage,
  });
}
