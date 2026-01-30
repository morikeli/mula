import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maverick_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:maverick_app/presentation/widgets/auth_gate.dart';
import 'package:maverick_app/presentation/views/onboarding_screen.dart';
import 'package:maverick_app/routes.dart';

import 'core/helpers/firebase_options.dart';
import 'core/services/auth_service.dart';
import 'core/services/pin_service.dart';
import 'core/services/transaction_service.dart';
import 'core/theme/theme.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/pin_repo.dart';
import 'data/repositories/transaction_repo.dart';
import 'presentation/bloc/pin_bloc/pin_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final seen = await Prefs.hasSeenOnboarding();
  runApp(MaverickApp(skipOnboarding: seen));

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MaverickApp extends StatelessWidget {
  final bool skipOnboarding;

  const MaverickApp({super.key, required this.skipOnboarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository(AuthService())),
        RepositoryProvider(create: (context) => PinRepository(PinService())),
        // RepositoryProvider(create: (context) => TransactionRepository(TransactionService())),

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => PinBloc(context.read<PinRepository>())),
          // BlocProvider(create: (context) => PinBloc(context.read<PinRepository>())),
      
        ],
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
    );
  }
}
