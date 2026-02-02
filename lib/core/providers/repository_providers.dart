import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repositories/auth_repo.dart';
import '../../data/repositories/pin_repo.dart';
import '../../data/repositories/transaction_repo.dart';
import '../services/auth_service.dart';
import '../services/pin_service.dart';
import '../services/transaction_service.dart';

// Provides repositories used across the app.
class RepositoryProviders extends StatelessWidget {
  final Widget child;
  const RepositoryProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository(AuthService())),
        RepositoryProvider(create: (_) => PinRepository(PinService())),
        RepositoryProvider(
          create: (_) => TransactionRepository(
            TransactionService(
              FirebaseFirestore.instance,
              FirebaseAuth.instance,
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
