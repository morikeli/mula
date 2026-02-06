import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../../cubits/wallet/wallet_balance_cubit.dart';
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
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async => context.read<TransactionsBloc>().add(TransactionHistoryRequested()),
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is IsAuthenticated) {
                context.read<TransactionsBloc>().add(
                  TransactionHistoryRequested(),
                );
              }
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/send-money');
        },
        child: Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
      ),
    );
  }
}
