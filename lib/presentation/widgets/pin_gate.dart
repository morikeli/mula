import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_toasts.dart';
import '../../core/utils/loading_indicators.dart';
import '../bloc/pin_bloc/pin_bloc.dart';
import '../views/auth/pin/pin_prompt_screen.dart';
import '../views/auth/pin/pin_setup_screen.dart';

class PinGate extends StatefulWidget {
  const PinGate({super.key});

  @override
  State<PinGate> createState() => _PinGateState();
}

class _PinGateState extends State<PinGate> {
  @override
  void initState() {
    super.initState();
    // Use the provided PinBloc from the widget tree instead of creating a new one
    context.read<PinBloc>().add(CheckPinStatusRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinBloc, PinState>(
      listener: (context, pinState) {
        if (pinState is PinError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppToast.showError(context, title: pinState.errorMessage.toString());
          });
        }
      },
      builder: (context, pinState) {
        if (pinState is PinLoading) {
          return AppLoadingIndicators.loadingIndicatorLarge();
        }

        // If an error occurs while checking/creating the PIN, prompt the user
        // to enter their PIN on retry (listener already shows
        // a toast with the error message).
        if (pinState is PinSet || pinState is PinError) {
          return PINScreen();
        }

        if (pinState is PinNotSet) {
          return PinSetupScreen();
        }

        // For any other intermediate state (e.g. initial), show a loading
        // indicator while the check completes to avoid briefly showing the
        // PinSetupScreen when a PIN actually exists.
        return AppLoadingIndicators.loadingIndicatorLarge();
      },
    );
  }
}
