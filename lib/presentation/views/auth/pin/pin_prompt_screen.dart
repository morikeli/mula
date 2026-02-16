import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

import '../../../../core/helpers/app_vibrations.dart';
import '../../../../core/utils/app_toasts.dart';
import '../../../../core/utils/loading_indicators.dart';
import '../../../bloc/pin_bloc/pin_bloc.dart';
import '../../../widgets/common/footer.dart';
import '../../../widgets/forms/pin_prompt_form.dart';

class PINScreen extends StatefulWidget {
  static String routeName = '/pin-prompt-screen';
  const PINScreen({super.key});

  @override
  State<PINScreen> createState() => _PINScreenState();
}

class _PINScreenState extends State<PINScreen> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pinScreenAppBar(context),
      body: BlocConsumer<PinBloc, PinState>(
        listener: (context, state) {
          if (state is PinSet) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) Navigator.pushReplacementNamed(context, '/home');
            });
          } else if (state is PinError) {
            setState(() {
              _hasError = true;
            });
            AppVibrations.vibrateOnError();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppToast.showError(context, title: state.errorMessage.toString());
            });
          }
        },
        builder: (context, state) {
          if (state is PinLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }
          return PINPromptForm(hasError: _hasError,);
        },
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Footer(
          primaryText: "Don't have a PIN? ",
          redirectText: "Create your PIN",
          redirectTo: TapGestureRecognizer()
            ..onTap = () => Navigator.pushNamed(context, '/create-pin'),
        ),
      ],
    );
  }

  AppBar pinScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Enter your PIN',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}
