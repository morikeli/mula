import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maverick_app/data/models/transaction_model.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/app_toasts.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../../../data/repositories/transaction_repo.dart';

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
