import 'package:flutter/material.dart';

import '../../../core/helpers/form_validation.dart';
import '../common/form_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> formErrors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailInputField(emailController: _emailController),
          const SizedBox(height: 24.0),
          RequestResetCodeBtn(formKey: _formKey, emailController: _emailController),
        ],
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _emailController,
      label: "Email",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateEmail(value);
      },
    );
  }
}

class RequestResetCodeBtn extends StatelessWidget {
  const RequestResetCodeBtn({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
  }) : _formKey = formKey, _emailController = emailController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // ResetPasswordDialog.showResetCodeSentDialog(
            //   context,
            //   _emailController.text,
            // );
          }
        },
        child: const Text(
          'Send reset code',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
