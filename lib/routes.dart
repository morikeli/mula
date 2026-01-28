import 'package:flutter/material.dart';
import 'presentation/widgets/homescreen.dart';

import 'presentation/views/auth/forgot-password/forgot_password_screen.dart';
import 'presentation/views/auth/login_screen.dart';
import 'presentation/views/auth/pin/pin_screen.dart';
import 'presentation/views/auth/pin/pin_setup_screen.dart';
import 'presentation/views/auth/pin/reset_pin.dart';
import 'presentation/views/onboarding_screen.dart';
import 'presentation/views/auth/otp/otp_screen.dart';
import 'presentation/views/auth/reset-password/reset_password_screen.dart';
import 'presentation/views/auth/signup_screen.dart';
import 'presentation/views/profile/edit_profile.dart';
import 'presentation/views/profile/profile_screen.dart';
import 'presentation/views/transaction/transaction_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  TransactionScreen.routeName: (context) => TransactionScreen(),
  PinSetupScreen.routeName: (context) => PinSetupScreen(),
  ResetPinScreen.routeName: (context) => ResetPinScreen(),
  PINScreen.routeName: (context) => PINScreen(),
};
