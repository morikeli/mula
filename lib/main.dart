import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/helpers/firebase_options.dart';
import 'core/helpers/prefs.dart';
import 'core/theme/theme.dart';
import 'core/providers/repository_providers.dart';
import 'core/providers/bloc_providers.dart';
import 'package:toastification/toastification.dart';
import 'presentation/views/onboarding_screen.dart';
import 'presentation/widgets/auth_gate.dart';
import 'presentation/widgets/connectivity_listener.dart';
import 'routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final seen = await Prefs.hasSeenOnboarding();
  runApp(MulaApp(skipOnboarding: seen));

  // whenever app initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MulaApp extends StatelessWidget {
  final bool skipOnboarding;

  const MulaApp({super.key, required this.skipOnboarding});

  @override
  Widget build(BuildContext context) {
    return RepositoryProviders(
      child: AppBlocProviders(
        child: AdaptiveTheme(
          dark: MulaAppTheme.darkTheme,
          light: MulaAppTheme.lightTheme,
          initial: AdaptiveThemeMode.dark,
          builder: (theme, darkTheme) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mula',
            darkTheme: darkTheme,
            theme: theme,
            // Insert ConnectivityListener inside MaterialApp's builder so it
            // can access Directionality and other inherited widgets provided
            // by MaterialApp.
            builder: (context, child) => ToastificationWrapper(
              child: ConnectivityListener(
                child: child ?? const SizedBox.shrink(),
              ),
            ),
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
