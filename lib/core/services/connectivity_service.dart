import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity helper service.
///
/// Wraps the `connectivity_plus` plugin and exposes two convenience
/// primitives used by the app:
///
/// - `onConnectivityChanged`: the raw stream emitted by the plugin. Note
///   that on some platforms or plugin implementations the stream items
///   may be a single `ConnectivityResult` value, while other implementations
///   might emit a collection/Iterable of results. Consumers that need a
///   strongly-typed `bool` should use `connectionStatusStream` instead.
///
/// - `connectionStatusStream`: a normalized `Stream<bool>` that yields `true`
///   when the device appears to have any network connectivity (Wi-Fi or
///   mobile) and `false` otherwise. This stream handles both single-value
///   and iterable events from the plugin and falls back to `false` for
///   unknown event shapes.
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  /// Raw connectivity change stream from `connectivity_plus`.
  ///
  /// Consumers may prefer `connectionStatusStream` which provides a
  /// normalized boolean view of connectivity state.
  get onConnectivityChanged => _connectivity.onConnectivityChanged;

  /// Normalized stream that emits `true` when the device has network access.
  ///
  /// Implementation notes:
  /// - Uses an `async*` generator to guarantee the returned stream has the
  ///   static type `Stream<bool>` regardless of what the underlying plugin
  ///   emits.
  /// - Handles both `ConnectivityResult` items and Iterable event shapes by
  ///   attempting a cast; unknown shapes yield `false`.
  Stream<bool> get connectionStatusStream async* {
    await for (final event in _connectivity.onConnectivityChanged) {
      // Typical case: plugin emits a single ConnectivityResult value.
      if (event is ConnectivityResult) {
        yield event != ConnectivityResult.none;
        continue;
      }

      // Some plugin/platform combinations may emit a collection of results.
      // Attempt to treat the event as an Iterable and evaluate whether any
      // entry represents an available connection.
      try {
        final iterable = event as Iterable;
        yield iterable.cast<ConnectivityResult>().any((e) => e != ConnectivityResult.none);
        continue;
      } catch (_) {}

      // Unknown event shape — conservatively report disconnected.
      yield false;
    }
  }

  /// One-off connectivity check.
  ///
  /// Returns `true` if `Connectivity.checkConnectivity()` reports a
  /// non-`none` result. Useful for quick synchronous checks (e.g. before
  /// attempting a network call), while `connectionStatusStream` should be
  /// used to observe changes over time.
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
