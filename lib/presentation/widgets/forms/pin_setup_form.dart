import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/helpers/form_validation.dart';
import '../../bloc/pin_bloc/pin_bloc.dart';
import '../common/form_field.dart';

class PINSetupForm extends StatefulWidget {
  const PINSetupForm({super.key});

  @override
  State<PINSetupForm> createState() => _PINSetupFormState();
}

class _PINSetupFormState extends State<PINSetupForm> {
  final TextEditingController pinInputController = TextEditingController();
  final TextEditingController confirmPinInputController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            pinInputTextField(),
            SizedBox(height: 12.0),
            confirmPinInputTextField(),
            SizedBox(height: 12.0),
            savePinBtn(context),
          ],
        ),
      ),
    );
  }

  Row savePinBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              final form = _formKey.currentState;

                if (form != null && form.validate()) {
                final createUserPin = pinInputController.text.trim();
                final userUid = FirebaseAuth.instance.currentUser!.uid;

                context.read<PinBloc>().add(CreatePinRequested(createUserPin, userUid));
              }
            },
            child: Text('Save PIN'),
          ),
        ),
      ],
    );
  }

  CustomTextFormField confirmPinInputTextField() {
    return CustomTextFormField(
      controller: confirmPinInputController,
      label: 'Confirm your PIN',
      icon: CupertinoIcons.circle_grid_3x3_fill,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePIN(
          pinInputController.text.trim(),
          value,
        );
      },
    );
  }

  CustomTextFormField pinInputTextField() {
    return CustomTextFormField(
      controller: pinInputController,
      label: 'Enter your PIN',
      icon: CupertinoIcons.circle_grid_3x3,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePIN(
          value,
          pinInputController.text.trim(),
        );
      },
    );
  }
}
