import 'package:flutter/material.dart';
import 'presentation/views/notifications/notifications_screen.dart';
import 'presentation/views/transactions/transaction_screen.dart';
import 'presentation/widgets/homescreen.dart';

import 'presentation/views/auth/forgot_password_screen.dart';
import 'presentation/views/auth/login_screen.dart';
import 'presentation/views/auth/pin/pin_prompt_screen.dart';
import 'presentation/views/auth/pin/pin_setup_screen.dart';
import 'presentation/views/onboarding_screen.dart';
import 'presentation/views/auth/signup_screen.dart';
import 'presentation/views/profile/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  TransactionScreen.routeName: (context) => TransactionScreen(),
  PinSetupScreen.routeName: (context) => PinSetupScreen(),
  PINScreen.routeName: (context) => PINScreen(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
};
