part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure(this.errorMessage);
}

class UserSearchLoading extends ProfileState {}

class UserSearchLoaded extends ProfileState {
  final List<UserModel> users;
  UserSearchLoaded(this.users);
}

class UserSearchError extends ProfileState {
  final String message;
  UserSearchError(this.message);
}
