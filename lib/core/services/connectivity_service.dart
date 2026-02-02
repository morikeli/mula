import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

// Simple wrapper around `connectivity_plus` exposing a stream and a helper
// to check whether the device appears to be connected to a network.
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Emits connectivity change events from the underlying plugin.
  //
  // The underlying plugin may emit either a single `ConnectivityResult` or
  // a collection on some platforms/implementations; we expose the raw
  // stream (no explicit static type) and normalize downstream where needed.
  get onConnectivityChanged => _connectivity.onConnectivityChanged;

  /// Emits `true` when the device has any network connectivity (wifi/mobile).
  Stream<bool> get connectionStatusStream => onConnectivityChanged.map((event) {
    if (event is Iterable) {
      return event.any((e) => e != ConnectivityResult.none);
    }
    return event != ConnectivityResult.none;
  });

  // Quick synchronous check if the device currently has network connectivity.
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
