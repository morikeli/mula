part of 'pin_bloc.dart';

@immutable
sealed class PinEvent {}

final class CheckPinStatusRequested extends PinEvent {
  final String userId;

  CheckPinStatusRequested({required this.userId});
}

final class VerifyPinRequested extends PinEvent {
  final String pin, uid;
  VerifyPinRequested(this.pin, this.uid);
}

final class CreatePinRequested extends PinEvent {
  final String pin;
  final String userId;

  CreatePinRequested(this.pin, this.userId);
}
