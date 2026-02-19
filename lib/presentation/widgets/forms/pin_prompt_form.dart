import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/theme.dart';
import '../../bloc/pin_bloc/pin_bloc.dart';

class PINPromptForm extends StatefulWidget {
  const PINPromptForm({super.key, required this.hasError});
  final bool hasError;


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
            forceErrorState: widget.hasError,
            defaultPinTheme: MulaAppTheme.defaultPinTheme(context),
            focusedPinTheme: MulaAppTheme.defaultPinTheme(context).copyWith(
              decoration: MulaAppTheme.defaultPinTheme(context).decoration!.copyWith(
                border: Border.all(color: kPrimaryColor, width: 2),
              ),
            ),
            errorPinTheme: MulaAppTheme.defaultPinTheme(context).copyWith(
              decoration: MulaAppTheme.defaultPinTheme(context).decoration!.copyWith(
                border: Border.all(color: kDangerColor, width: 2),
              ),
            ),
            submittedPinTheme: MulaAppTheme.defaultPinTheme(context),
            showCursor: true,
            onCompleted: (pin) {
              final userId = FirebaseAuth.instance.currentUser!.uid;
              context.read<PinBloc>().add(VerifyPinRequested(pin, userId));
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
