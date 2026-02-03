import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/loading_indicators.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/pin/pin_prompt_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      // No global listener here: child screens (`LoginScreen` and
      // `PINScreen`) show toasts for errors. Keeping the gate free of toasts
      // prevents duplicate notifications when both ancestor and descendant
      // listen to the same `AuthBloc` or `PinBloc`.
      listener: (context, authState) {},
      builder: (context, authState) {
        if (authState is AuthLoading) {
          return AppLoadingIndicators.loadingIndicatorLarge();
        }

        // Check if user is logged out
        if (authState is! IsAuthenticated) {
          return LoginScreen();
        }

        return PINScreen();
      },
    );
  }
}
