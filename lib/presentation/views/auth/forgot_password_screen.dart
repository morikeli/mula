import 'package:flutter/material.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/forms/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Forgot password'),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            AppToast.showSuccess(context, title: "Password reset email sent successfully!");
          } else if (state is PasswordResetFailure) {
            AppToast.showError(context, title: "${state.error}!");
          }
          
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const SizedBox(height: 12.0),
                Text(
                  'Enter your email to recieve your password reset code.',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                ForgotPasswordForm(),
              ],
            ),
          );
        },
      ),
    );
  }
}
