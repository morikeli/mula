part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class IsAuthenticated extends AuthState {
  final LoginModel loginModel;

  IsAuthenticated({required this.loginModel});
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