import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repo.dart';
import '../../data/repositories/notification_repo.dart';
import '../../data/repositories/pin_repo.dart';
import '../../data/repositories/transaction_repo.dart';
import '../../presentation/bloc/auth_bloc/auth_bloc.dart';
import '../../presentation/bloc/notifications_bloc/notifications_bloc.dart';
import '../../presentation/bloc/pin_bloc/pin_bloc.dart';
import '../../presentation/bloc/transaction_bloc/transactions_bloc.dart';
import '../../presentation/cubits/connectivity/connectivity_cubit.dart';
import '../../core/services/connectivity_service.dart';
import '../../presentation/cubits/wallet/wallet_balance_cubit.dart';
import '../../presentation/cubits/wallet/wallet_visibility_cubit.dart';

// Provides Blocs used across the app.
class AppBlocProviders extends StatelessWidget {
  final Widget child;
  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(context.read<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => PinBloc(context.read<PinRepository>()),
        ),
        BlocProvider(
          create: (context) => TransactionsBloc(
            repository: context.read<TransactionRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              NotificationBloc(context.read<NotificationRepository>()),
        ),

        // 2. Cubit
        BlocProvider(
          create: (context) =>
              ConnectivityCubit(context.read<ConnectivityService>()),
        ),
        BlocProvider(create: (context) => WalletVisibilityCubit()),
        BlocProvider(
          create: (context) => WalletBalanceCubit(
            repository: context.read<TransactionRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
