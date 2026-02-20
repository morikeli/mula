import 'package:flutter/material.dart';

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
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/create-pin'),
            child: Text('Reset PIN'),
          ),
        ),
      ],
    );
  }
}
