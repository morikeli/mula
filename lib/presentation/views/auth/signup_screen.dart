import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_toasts.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/forms/signup_form.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Create Account'),

      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AccountCreated) {
            Navigator.pushNamed(context, '/login');
          } else if (state is AccountCreationFailed) {
            AppToast.showError(context, title: 'Account creation failed!', message: state.errorMessage.toString());
          }
        },

        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }

          return SignupScreenBody();
        },
      ),

      // Footer
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      persistentFooterButtons: [
        Footer(
          primaryText: "Already have an account? ",
          redirectText: "Login",
          redirectTo: TapGestureRecognizer()
            ..onTap = () => Navigator.pushNamed(context, '/login'),
        ),
      ],
    );
  }
}

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SignupScreenSubTitle(),
            SizedBox(height: 16.0),
            SignupForm(),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

class SignupScreenSubTitle extends StatelessWidget {
  const SignupScreenSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Simplify your payments with us',
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    );
  }
}
