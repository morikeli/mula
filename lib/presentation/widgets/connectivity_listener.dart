import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_toasts.dart';
import '../cubits/connectivity/connectivity_cubit.dart';

// Listens to connectivity changes and shows/dismisses a toastification
// notification when offline/online.
class ConnectivityListener extends StatefulWidget {
  final Widget child;
  const ConnectivityListener({super.key, required this.child});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  dynamic _offlineToastController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, bool>(
      listener: (context, connected) {
        // Delay showing/dismissing toasts until after the first frame so
        // `Directionality` (from MaterialApp) is available.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          if (!connected) {
            _offlineToastController ??= AppToast.showWarning(
                context,
                title: 'No internet connection!',
                message: 'Some features may be unavailable.',
                autoCloseDuration: null,
                pauseOnHover: false,
                showProgressBar: false,
              );
          } else {
            // Close offline toast if present.
            try {
              _offlineToastController?.close();
            } catch (_) {}
            _offlineToastController = null;

            // TODO: ```Success toastification is shown everytime the app is opened
            //  Update code to close toastification automatically if user is
            // connected to the internet
            // ```
            // AppToast.showSuccess(context, title: 'Back online!');
          }
        });
      },
      child: widget.child,
    );
  }
}
