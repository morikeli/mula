import '../../core/services/pin_service.dart';
import '../models/pin_model.dart';

class PinRepository {
  final PinService _pinService;

  PinRepository(this._pinService);

  Future<PinModel> createPin(String pin, String uid) async {
    if (pin.length < 4) {
      throw Exception('PIN must be at least 4 digits');
    }
    final userId = await _pinService.savePin(pin, uid);
    return PinModel(pin: userId.pin, userId: userId.userId);
  }

  Future<bool> verifyPin(String pin) {
    return _pinService.verifyPin(pin);
  }

  Future<bool> isPinSet() {
    return _pinService.isPinSet();
  }

  Future<void> resetPin() {
    return _pinService.clearPin();
  }
}
