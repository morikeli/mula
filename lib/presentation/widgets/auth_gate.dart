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
    return BlocBuilder(
      builder: (context, authState) {
        if (authState is AuthInitial || authState is AuthLoading) {
          AppLoadingIndicators.loadingIndicatorLarge();
        }

        // Check if user is logged out
        if (authState != IsAuthenticated) {
          return LoginScreen();
        }

        if (authState is IsAuthenticated) {
          return BlocProvider(
            create: (_) =>
                PinBloc(context.read<PinRepository>())
                  ..add(CheckPinStatusRequested()),
            child: BlocBuilder(
              builder: (context, pinState) {
                if (pinState is PinLoading) {
                  return AppLoadingIndicators.loadingIndicatorLarge();
                }

                // Prompt the user for their PIN
                if (pinState is PinSet) {
                  return PINScreen();
                }

                // check if the user had created and saved their PIN
                if (pinState is PinNotSet) {
                  return PinSetupScreen();
                }

                return AppLoadingIndicators.loadingIndicatorLarge();
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
