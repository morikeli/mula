import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../core/theme/colors.dart';
import '../../bloc/pin_bloc/pin_bloc.dart';

class PINPromptForm extends StatefulWidget {
  const PINPromptForm({super.key});

  @override
  State<PINPromptForm> createState() => _PINPromptFormState();
}

class _PINPromptFormState extends State<PINPromptForm> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 72,
      height: 64,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.12,
        vertical: 16.0,
      ),
      child: ListView(
        children: [
          // Screen header
          Text(
            'Keep your PIN secure and do not share it with anyone.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .16),
          // PIN input field
          Pinput(
            length: 4,
            controller: _pinController,
            focusNode: _focusNode,
            obscureText: true,
            autofocus: true,
            defaultPinTheme: defaultTheme,
            focusedPinTheme: defaultTheme.copyWith(
              decoration: defaultTheme.decoration!.copyWith(
                border: Border.all(color: kPrimaryColor, width: 2),
              ),
            ),
            submittedPinTheme: defaultTheme,
            showCursor: true,
            onCompleted: (pin) {
              context.read<PinBloc>().add(VerifyPinRequested(pin));
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
