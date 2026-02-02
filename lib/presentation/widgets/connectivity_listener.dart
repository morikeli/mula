import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_toasts.dart';
import '../../presentation/bloc/connectivity/connectivity_cubit.dart';

// Listens to connectivity changes and shows/dismisses a toastification
// notification when offline/online.
class ConnectivityListener extends StatefulWidget {
  final Widget child;
  const ConnectivityListener({super.key, required this.child});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  bool _offlineToastVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, bool>(
      listener: (context, connected) {
        if (!connected) {
          // Show an undismissable persistent offline toast. AppToast.showWarning
          // does not return a controller, so just show it and record visibility.
          AppToast.showWarning(
            context,
            title: 'No internet connection!',
            message: 'Some features may be unavailable.',
            autoCloseDuration: null,
            pauseOnHover: false,
            showProgressBar: false,
          );
          _offlineToastVisible = true;
        } else {
          // If we showed an offline toast previously, mark it dismissed.
          _offlineToastVisible = false;
          AppToast.showSuccess(context, title: 'Back online!');
        }
      },
      child: widget.child,
    );
  }
}
