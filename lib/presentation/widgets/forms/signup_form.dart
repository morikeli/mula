import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/form_validation.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../common/form_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FirstNameInputField(firstNameController: firstNameController),
          const SizedBox(height: 20.0),
          LastNameInputField(lastNameController: lastNameController),
          const SizedBox(height: 20.0),
          EmailInputField(emailController: emailController),
          const SizedBox(height: 20),
          MobileNumberInputField(mobileNumberController: mobileNumberController),
          const SizedBox(height: 20),
          PasswordInputField(passwordController: passwordController),
          const SizedBox(height: 20),
          ConfirmPasswordInputField(
            confirmPasswordController: confirmPasswordController,
            passwordController: passwordController,
          ),
          SizedBox(height: 12.0),
          // TermsAndConditions(widget: widget),
          const SizedBox(height: 20.0),
          SignupBtn(
            formKey: formKey,
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            emailController: emailController,
            mobileNumberController: mobileNumberController,
            passwordController: passwordController,
          ),
        ],
      ),
    );
  }
}

class FirstNameInputField extends StatelessWidget {
  const FirstNameInputField({
    super.key,
    required this.firstNameController,
  });

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: firstNameController,
      label: "First Name",
      icon: CupertinoIcons.person,
      keyboardType: TextInputType.name,
      validator: (value) {
        return FormValidation.validateFirstName(value);
      },
    );
  }
}

class LastNameInputField extends StatelessWidget {
  const LastNameInputField({
    super.key,
    required this.lastNameController,
  });

  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: lastNameController,
      label: "Last Name",
      icon: CupertinoIcons.person,
      keyboardType: TextInputType.name,
      validator: (value) {
        return FormValidation.validateLastName(value);
      },
    );
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      label: "Email",
      icon: CupertinoIcons.envelope,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateEmail(value);
      },
    );
  }
}

class MobileNumberInputField extends StatelessWidget {
  const MobileNumberInputField({
    super.key,
    required this.mobileNumberController,
  });

  final TextEditingController mobileNumberController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: mobileNumberController,
      label: "Mobile Number",
      icon: CupertinoIcons.phone_circle,
      keyboardType: TextInputType.number,
      validator: (value) {
        return FormValidation.validatePhoneNumber(value);
      },
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      label: "Password",
      icon: CupertinoIcons.lock_shield,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(passwordController.text, value);
      },
    );
  }
}

class ConfirmPasswordInputField extends StatelessWidget {
  const ConfirmPasswordInputField({
    super.key,
    required this.confirmPasswordController,
    required this.passwordController,
  });

  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: confirmPasswordController,
      label: "Confirm Password",
      icon: CupertinoIcons.lock_shield,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(value, passwordController.text);
      },
    );
  }
}

// class TermsAndConditions extends StatelessWidget {
//   const TermsAndConditions({
//     super.key,
//     required this.widget,
//   });

//   final SignupForm widget;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox.adaptive(
//           value: widget.authController.hasReadTermsAndConditions.value,
//           activeColor: Colors.teal.shade900,
//           onChanged: (value) {
//             widget.authController.hasReadTermsAndConditions.value =
//                 value ?? false;
//           },
//         ),
//         Text(
//           'Accept Terms and Conditions',
//           style: TextStyle(color: Colors.teal.shade900),
//         ),
//       ],
//     );
//   }
// }

class SignupBtn extends StatelessWidget {
  const SignupBtn({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.mobileNumberController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController mobileNumberController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final form = formKey.currentState;

          if (form != null && form.validate()) {
            final firstName = firstNameController.text.trim();
            final lastName = lastNameController.text.trim();
            final email = emailController.text.trim();
            final mobileNumber = mobileNumberController.text.trim();
            final username = '$firstName $lastName';
            final password = passwordController.text.trim();

            context.read<AuthBloc>().add(
              SignupRequested(username, email, mobileNumber, password),
            );
          }
        },
        child: const Text(
          'Create account',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
