import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/pin_repo.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final PinRepository pinRepository;

  PinBloc(this.pinRepository) : super(PinInitial()) {
    on<CheckPinStatusRequested>(_onCheck);
    on<VerifyPinRequested>(_onVerify);
    on<CreatePinRequested>(_onCreate);
  }

  Future<void> _onCheck(
    CheckPinStatusRequested event,
    Emitter<PinState> emit,
  ) async {
    emit(PinLoading());

    try {
      final isSet = await pinRepository.isPinSet(event.userId);

      if (isSet) {
        emit(PinSet());
      } else {
        emit(PinNotSet());
      }
    } catch (e) {
      emit(PinError(e.toString()));
    }
  }

  Future<void> _onVerify(
    VerifyPinRequested event,
    Emitter<PinState> emit,
  ) async {
    emit(PinLoading());

    try {
      final isValid = await pinRepository.verifyPin(event.pin);

      if (isValid) {
        emit(PinSet());
      } else {
        emit(PinError("Invalid PIN! Please try again."));
      }
    } catch (e) {
      emit(PinError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreatePinRequested event,
    Emitter<PinState> emit,
  ) async {
    emit(PinLoading());

    try {
      await pinRepository.createPin(event.pin, event.userId);

      emit(PinSet());
    } catch (e) {
      emit(PinError(e.toString()));
    }
  }
}
