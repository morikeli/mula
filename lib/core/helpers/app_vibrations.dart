import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class AppVibrations {
  static void vibrateOnError() {
    Vibration.vibrate(duration: 1500, preset: VibrationPreset.pulseWave);
  }
}