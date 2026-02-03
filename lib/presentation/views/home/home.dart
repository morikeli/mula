import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../../bloc/wallet/wallet_balance_cubit.dart';
import '../../widgets/common/recent_transactions.dart';
import 'widgets/avatar.dart';
import 'widgets/recent_transactions_title.dart';
import 'widgets/wallet_card.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String routeName = '/home';

  @override
  void initState() {
    super.initState();
    // Check if we are already authenticated on startup
    final authState = context.read<AuthBloc>().state;
    if (authState is IsAuthenticated) {
      final uid = authState.user.uid;
      // start wallet balance listener
      context.read<WalletBalanceCubit>().start(uid);
      // load transactions
      context.read<TransactionsBloc>().add(TransactionHistoryRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for auth state and request transactions only when authenticated.
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is IsAuthenticated) {
            context.read<TransactionsBloc>().add(TransactionHistoryRequested());
          }
        },
        child: Column(
          children: [
            // User Avatar and sreetings
            UserAvatarAndGreetings(),
            // Wallet balance
            WalletCard(),
            SizedBox(height: 12.0),
            // Recent transactions
            RecentTransactionsTitle(),
            RecentTransactions(),
          ],
        ),
      ),
    );
  }
}
