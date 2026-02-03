import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const _onboardingKey = 'onboarding_seen';

  // Persists a flag indicating that the user has seen/completed the onboarding flow.
  // 
  // This function stores a boolean value in the app's persistent preferences so that
  // subsequent app launches can detect that onboarding does not need to be shown again.
  // Returns a Future that completes when the value has been written.
   
  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
  
  // Checks whether the user has previously seen the onboarding flow by reading a boolean
  // flag from persistent preferences.
  // 
  // Returns a Future<bool> that completes with `true` if the stored flag indicates the
  // user has seen onboarding; if no value exists, it completes with `false`.
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }
}
