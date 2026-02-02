import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maverick_app/presentation/widgets/auth_gate.dart';
import 'package:maverick_app/presentation/views/onboarding_screen.dart';
import 'package:maverick_app/routes.dart';

import 'core/helpers/firebase_options.dart';
import 'core/helpers/prefs.dart';
import 'core/theme/theme.dart';
import 'core/providers/repository_providers.dart';
import 'core/providers/bloc_providers.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final seen = await Prefs.hasSeenOnboarding();
  runApp(MaverickApp(skipOnboarding: seen));

  // whenever app initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MaverickApp extends StatelessWidget {
  final bool skipOnboarding;

  const MaverickApp({super.key, required this.skipOnboarding});

  @override
  Widget build(BuildContext context) {
    return RepositoryProviders(
      child: AppBlocProviders(
        child: ConnectivityListener(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mula',
            darkTheme: MulaAppTheme.darkTheme,
            theme: MulaAppTheme.lightTheme,
            // If the user already saw onboarding, place AuthGate as the home
            // so no onboarding flash occurs. Otherwise start at onboarding.
            home: skipOnboarding ? const AuthGate() : null,
            initialRoute: OnboardingScreen.routeName,
            routes: routes,
          ),
        ),
      ),
    );
  }
}
