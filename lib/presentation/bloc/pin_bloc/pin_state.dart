part of 'pin_bloc.dart';

@immutable
sealed class PinState {}


final class PinInitial extends PinState {}

final class PinLoading extends PinState {}

final class PinExists extends PinState {}

final class PinNotSet extends PinState {}

final class PinVerified extends PinState {}

final class PinError extends PinState {
  final String errorMessage;
  PinError(this.errorMessage);
}
