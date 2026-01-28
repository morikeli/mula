part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginRequested extends AuthEvent {
  final String username, password;

  LoginRequested(this.username, this.password);
}

final class SignupRequested extends AuthEvent {
  final String username, email, mobileNumber, password;

  SignupRequested(this.username, this.email, this.mobileNumber, this.password);
}

final class AuthUserChanged extends AuthEvent {
  final User? user;
  AuthUserChanged(this.user);
}

final class LogoutRequested extends AuthEvent {}
