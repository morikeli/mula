part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class IsAuthenticated extends AuthState {
  final UserModel user;

  IsAuthenticated({required this.user});
}

final class AuthFailed extends AuthState {
  final String errorMessage;

  AuthFailed(this.errorMessage);
}

final class AccountCreated extends AuthState {
  final SignupModel signupModel;

  AccountCreated({required this.signupModel});
}

final class AccountCreationFailed extends AuthState {
  final String errorMessage;

  AccountCreationFailed(this.errorMessage);
}

class PasswordResetSuccess extends AuthState {}

class PasswordResetFailure extends AuthState {
  final String error;

  PasswordResetFailure(this.error);
}

final class UserLoggedOut extends AuthState {}

final class UserLogoutFailed extends AuthState {
  final String errorMessage;

  UserLogoutFailed(this.errorMessage);
}