import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/loading_indicators.dart';
import '../../data/repositories/pin_repo.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/pin_bloc/pin_bloc.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/pin/pin_prompt_screen.dart';
import '../views/auth/pin/pin_setup_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthFailed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppToast.showError(context, title: authState.errorMessage.toString());
          });
        }
      },
      builder: (context, authState) {
        if (authState is AuthLoading) {
          return AppLoadingIndicators.loadingIndicatorLarge();
        }

        // Check if user is logged out
        if (authState is! IsAuthenticated) {
          return LoginScreen();
        }

        return PinGate();
      },
    );
  }
}
