import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      // No global listener here: child screens (`PinSetupScreen` and
      // `PINScreen`) show toasts for errors. Keeping the gate free of toasts
      // prevents duplicate notifications when both ancestor and descendant
      // listen to the same `PinBloc`.
      listener: (context, pinState) {},
      builder: (context, pinState) {
        if (pinState is PinLoading) {
          return AppLoadingIndicators.loadingIndicatorLarge();
        }

        // Show the PIN prompt when a PIN exists.
        if (pinState is PinSet) {
          return PINScreen();
        }

        // If no PIN is set, show the setup screen so the user can create their PIN.
        if (pinState is PinNotSet || pinState is PinError) {
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
