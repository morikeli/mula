import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/form_validation.dart';
import '../../bloc/pin_bloc/pin_bloc.dart';
import '../common/form_field.dart';

class PINPromptForm extends StatefulWidget {
  const PINPromptForm({super.key});

  @override
  State<PINPromptForm> createState() => _PINPromptFormState();
}

class _PINPromptFormState extends State<PINPromptForm> {
  final TextEditingController pinInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            pinTextField(),
            SizedBox(height: 12.0),
            unlockBtn(context),
          ],
        ),
      ),
    );
  }

  Row unlockBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              final form = _formKey.currentState;

              if (form != null && form.validate()) {
                final userPin = pinInputController.text.trim();

                context.read<PinBloc>().add(VerifyPinRequested(userPin));
              }
            },
            child: Text('Unlock'),
          ),
        ),
      ],
    );
  }

  CustomTextFormField pinTextField() {
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
