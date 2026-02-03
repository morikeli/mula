part of 'pin_bloc.dart';

@immutable
sealed class PinEvent {}

final class CheckPinStatusRequested extends PinEvent {}

final class VerifyPinRequested extends PinEvent {
  final String pin;
  VerifyPinRequested(this.pin);
}

final class CreatePinRequested extends PinEvent {
  final String pin;
  final String userId;

  CreatePinRequested(this.pin, this.userId);
}
