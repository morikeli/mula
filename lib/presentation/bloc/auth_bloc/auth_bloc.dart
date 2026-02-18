import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/signup_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_authenticateUser);
    on<SignupRequested>(_createUserAccount);
    on<ForgotPasswordRequested>(_forgotPassword);
    on<LogoutRequested>(_logoutUser);
  }

  Future<void> _authenticateUser(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // app is loading
    emit(AuthLoading());
    try {
      final auth = await authRepository.getUserCredentials(
        event.username,
        event.password,
      );
      emit(IsAuthenticated(user: auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> _createUserAccount(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    // app is loading
    emit(AuthLoading());

    try {
      final user = await authRepository.createUserAccount(
        event.username,
        event.email,
        event.mobileNumber,
        event.password,
      );
      emit(AccountCreated(signupModel: user));
    } catch (e) {
      emit(AccountCreationFailed(e.toString()));
    }
  }

  Future<void> _forgotPassword(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.forgotPassword(event.email);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(PasswordResetFailure(e.toString()));
    }
  }

  Future<void> _logoutUser(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await authRepository.signOut();
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLogoutFailed(e.toString()));
    }
  }
}
