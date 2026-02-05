import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/common/notification_bell_icon.dart';
import '../../widgets/common/recent_transactions.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showGoBackToPreviousScreenBtn: false,
        appBarTitle: 'Recent Transactions',
        appBarTitleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20.0),
        actions: [
          NotificationBellIcon(),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => context.read<TransactionsBloc>().add(TransactionHistoryRequested()),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [RecentTransactions()],
          ),
        ),
      ),
    );
  }
}
