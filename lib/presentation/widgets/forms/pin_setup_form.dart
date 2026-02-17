import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/helpers/form_validation.dart';
import '../../bloc/pin_bloc/pin_bloc.dart';
import '../common/form_field.dart';

class PINSetupPinput extends StatefulWidget {
  const PINSetupPinput({super.key, required this.hasError});
  final bool hasError;

  @override
  State<PINSetupPinput> createState() => _PINSetupPinputState();
}

class _PINSetupPinputState extends State<PINSetupPinput> {
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();
  static const int pinLength = 4;

  @override
  void dispose() {
    pinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: ListView(
        children: [
          // Screen header
          Text(
            'PIN yako, siri yako',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .08),
          EnterPIN(
            pinController: pinController,
            pinLength: pinLength,
            context: context,
            hasError: widget.hasError,
          ),
          const SizedBox(height: 16.0),
          ConfirmPIN(
            confirmPinController: confirmPinController,
            pinLength: pinLength,
            pinController: pinController,
            hasError: widget.hasError,
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class ConfirmPIN extends StatelessWidget {
  const ConfirmPIN({
    super.key,
    required this.confirmPinController,
    required this.pinLength,
    required this.pinController,
    required this.hasError,
  });

  final TextEditingController confirmPinController;
  final int pinLength;
  final TextEditingController pinController;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Confirm your PIN'),
        const SizedBox(height: 8.0),
        Pinput(
          controller: confirmPinController,
          length: pinLength,
          obscureText: true,
          keyboardType: TextInputType.number,
          forceErrorState: hasError,
          defaultPinTheme: MulaAppTheme.defaultPinTheme(context),
          focusedPinTheme: MulaAppTheme.defaultPinTheme(context).copyWith(
            decoration: MulaAppTheme.defaultPinTheme(context).decoration!
                .copyWith(border: Border.all(color: kPrimaryColor, width: 2.0)),
          ),
          errorPinTheme: MulaAppTheme.defaultPinTheme(context).copyWith(
            decoration: MulaAppTheme.defaultPinTheme(context).decoration!
                .copyWith(border: Border.all(color: kDangerColor, width: 2.0)),
          ),
          validator: (value) {
            return FormValidation.validatePIN(pinController.text.trim(), value);
          },
          onCompleted: (pin) {
            if (pinController.text.trim() == pin) {
              context.read<PinBloc>().add(
                CreatePinRequested(
                  pinController.text.trim(),
                  FirebaseAuth.instance.currentUser!.uid,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class EnterPIN extends StatelessWidget {
  const EnterPIN({
    super.key,
    required this.pinController,
    required this.pinLength,
    required this.context,
    required this.hasError,
  });

  final TextEditingController pinController;
  final int pinLength;
  final BuildContext context;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter your PIN'),
        const SizedBox(height: 8.0),
        Pinput(
          controller: pinController,
          length: pinLength,
          obscureText: true,
          keyboardType: TextInputType.number,
          forceErrorState: hasError,
          defaultPinTheme: MulaAppTheme.defaultPinTheme(context),
          focusedPinTheme: MulaAppTheme.defaultPinTheme(context).copyWith(
            decoration: MulaAppTheme.defaultPinTheme(context).decoration!
                .copyWith(border: Border.all(color: kPrimaryColor, width: 2.0)),
          ),
          errorPinTheme: MulaAppTheme.defaultPinTheme(context).copyWith(
            decoration: MulaAppTheme.defaultPinTheme(context).decoration!
                .copyWith(border: Border.all(color: kDangerColor, width: 2.0)),
          ),
          validator: (value) {
            return FormValidation.validatePIN(value, pinController.text.trim());
          },
          onCompleted: (_) => FocusScope.of(context).nextFocus(),
        ),
      ],
    );
  }
}
