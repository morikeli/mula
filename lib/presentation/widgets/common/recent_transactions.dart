import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/app_toasts.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../../views/transactions/recent_transactions_tiles.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure this widget always takes remaining space so internal
    // children (ListView, Center) receive proper constraints.
    return Expanded(
      child: BlocConsumer<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          if (state is GetTransactionHistoryFailed) {
            AppToast.showError(context, title: state.errorMessage.toString());
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorMedium());
          }

          if (state is TransactionHistoryLoaded) {
            final txns = state.transactions;
            if (txns.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Text(
                      'No recent transactions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Your transaction history will appear here',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RecentTransactionsListTiles(txns: txns);
          }

          // default fallback
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
