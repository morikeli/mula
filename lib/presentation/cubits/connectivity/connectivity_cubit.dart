import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/connectivity_service.dart';

/// Emits `true` when connected, `false` when disconnected.
class ConnectivityCubit extends Cubit<bool> {
  final ConnectivityService _service;
  StreamSubscription<bool>? _sub;

  ConnectivityCubit(this._service) : super(true) {
    _init();
  }

  void _init() {
    _sub = _service.connectionStatusStream.listen((connected) {
      emit(connected);
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
