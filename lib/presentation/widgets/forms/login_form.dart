import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../common/form_field.dart';
import '../../../core/helpers/form_validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          emailTextField(),
          const SizedBox(height: 20),
          passwordTextField(),
          const SizedBox(height: 12.0),
          // "Remember Me" checkbox and "Forgot password" text
          checkBoxandForgotPassword(context),
          const SizedBox(height: 20.0),
          loginButton(context),
        ],
      ),
    );
  }

  SizedBox loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final form = formKey.currentState;

          if (form != null && form.validate()) {
            final username = emailController.text.trim();
            final password = passwordController.text.trim();

            context.read<AuthBloc>().add(LoginRequested(username, password));
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Row checkBoxandForgotPassword(BuildContext context) {
    return Row(
      children: [
        // Checkbox.adaptive(
        //   value: widget.authController.rememberMe.value,
        //   activeColor: Colors.teal.shade900,
        //   onChanged: (value) {
        //     widget.authController.rememberMe.value = value ?? false;
        //   },
        // ),
        // const Text('Remember me'),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forgot-password'),
          child: Text(
            'Forgot password?',
            style: TextStyle(
              color: kTextGreenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  CustomTextFormField passwordTextField() {
    return CustomTextFormField(
      controller: passwordController,
      label: "Password",
      icon: CupertinoIcons.lock,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(value, passwordController.text);
      },
    );
  }

  CustomTextFormField emailTextField() {
    return CustomTextFormField(
      controller: emailController,
      label: "Email",
      icon: CupertinoIcons.mail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateEmail(value);
      },
    );
  }
}
