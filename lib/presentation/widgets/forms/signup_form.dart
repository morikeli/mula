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
          firstNameTextField(),
          const SizedBox(height: 20.0),
          lastNameTextField(),
          const SizedBox(height: 20.0),
          emailTextField(),
          const SizedBox(height: 20),
          mobileNumberTextField(),
          const SizedBox(height: 20),
          passwordTextField(),
          const SizedBox(height: 20),
          confirmPasswordTextField(),
          SizedBox(height: 12.0),
          // termsAndConditionsCheckBox(),
          const SizedBox(height: 20.0),
          signupButton(context),
        ],
      ),
    );
  }

  SizedBox signupButton(BuildContext context) {
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

  // Row termsAndConditionsCheckBox() {
  //   return Row(
  //     children: [
  //       Checkbox.adaptive(
  //         value: widget.authController.hasReadTermsAndConditions.value,
  //         activeColor: Colors.teal.shade900,
  //         onChanged: (value) {
  //           widget.authController.hasReadTermsAndConditions.value =
  //               value ?? false;
  //         },
  //       ),
  //       Text(
  //         'Accept Terms and Conditions',
  //         style: TextStyle(color: Colors.teal.shade900),
  //       ),
  //     ],
  //   );
  // }

  CustomTextFormField confirmPasswordTextField() {
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

  CustomTextFormField passwordTextField() {
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

  CustomTextFormField emailTextField() {
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

  CustomTextFormField mobileNumberTextField() {
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

  CustomTextFormField lastNameTextField() {
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

  CustomTextFormField firstNameTextField() {
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
