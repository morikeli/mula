import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maverick_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:maverick_app/presentation/widgets/auth_gate.dart';
import 'package:maverick_app/presentation/views/onboarding_screen.dart';
import 'package:maverick_app/routes.dart';

import 'core/helpers/firebase_options.dart';
import 'core/helpers/prefs.dart';
import 'core/services/auth_service.dart';
import 'core/services/pin_service.dart';
import 'core/services/transaction_service.dart';
import 'core/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/pin_repo.dart';
import 'data/repositories/transaction_repo.dart';
import 'presentation/bloc/pin_bloc/pin_bloc.dart';
import 'presentation/bloc/transaction_bloc/transactions_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository(AuthService())),
        RepositoryProvider(create: (context) => PinRepository(PinService())),
        RepositoryProvider(
          create: (context) => TransactionRepository(
            TransactionService(
              FirebaseFirestore.instance,
              FirebaseAuth.instance,
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => PinBloc(context.read<PinRepository>()),
          ),
          BlocProvider(
            create: (context) => TransactionsBloc(repository: context.read<TransactionRepository>()),
          ),
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
