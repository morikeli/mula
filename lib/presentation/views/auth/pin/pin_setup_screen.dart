import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_vibrations.dart';
import '../../../../core/utils/app_toasts.dart';
import '../../../../core/utils/loading_indicators.dart';
import '../../../bloc/pin_bloc/pin_bloc.dart';
import '../../../widgets/common/appbar.dart';
import '../../../widgets/common/footer.dart';
import '../../../widgets/forms/pin_setup_pinput.dart';

class PinSetupScreen extends StatefulWidget {
  static String routeName = '/create-pin';
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: "Setup your PIN"),
      body: BlocConsumer<PinBloc, PinState>(
        listener: (context, state) {
          if (state is PinSet) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                AppToast.showSuccess(
                  context,
                  title: 'PIN created successfully',
                );
                Navigator.pushNamed(context, '/pin-prompt-screen');
              }
            });
          } else if (state is PinError) {
            setState(() => _hasError = true);
            AppVibrations.vibrateOnError();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                AppToast.showError(
                  context,
                  title: 'PIN creation error!',
                  message: state.errorMessage.toString(),
                );
              }
            });
          }
        },
        builder: (context, state) {
          if (state is PinLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }
          return PINSetupPinput(hasError: _hasError);
        },
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Footer(
          primaryText: "Already have a PIN? ",
          redirectText: "Enter your PIN",
          redirectTo: TapGestureRecognizer()
            ..onTap = () => Navigator.pushNamed(context, '/pin-prompt-screen'),
        ),
      ],
    );
  }
}
