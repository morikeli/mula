import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/app_toasts.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is IsAuthenticated) {
            Navigator.pushNamed(context, '/homescreen');
          } else if (state is AuthFailed) {
            AppToast.showError(context, title: state.errorMessage.toString());
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const SizedBox(height: 40),
                formIcon(),
                SizedBox(height: 24.0),
                formTitle(),
                const SizedBox(height: 12.0),
                formSubTitle(context),
                const SizedBox(height: 40),
                // LoginForm widget
                LoginForm(),
                const SizedBox(height: 32.0),
              ],
            ),
          );
        },
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      persistentFooterButtons: [
        Footer(
          primaryText: "Don't have an account? ",
          redirectText: "Sign up",
          redirectTo: TapGestureRecognizer()
            ..onTap = () => Navigator.pushNamed(context, '/signup'),
        ),
      ],
    );
  }


  Text formSubTitle(BuildContext context) {
    return Text(
      'Sign in to continue',
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    );
  }

  Text formTitle() {
    return Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Center formIcon() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: kContainerLightColor,
          shape: BoxShape.rectangle,
        ),
        padding: EdgeInsets.all(16.0),
        child: Icon(
          CupertinoIcons.creditcard_fill,
          color: kIconDarkColor,
          size: 28.0,
        ),
      ),
    );
  }
}
