import 'package:flutter/material.dart';

import '../../auth/pin/pin_setup_screen.dart';

class ResetPINButton extends StatelessWidget {
  const ResetPINButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Reset PIN btn
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              PinSetupScreen.routeName,
            ),
            child: Text('Reset PIN'),
          ),
        ),
      ],
    );
  }
}
