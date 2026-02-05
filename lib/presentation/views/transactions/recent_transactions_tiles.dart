import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/colors.dart';
import '../../../data/models/transaction_model.dart';

class RecentTransactionsListTiles extends StatelessWidget {
  const RecentTransactionsListTiles({
    super.key,
    required this.txns,
  });

  final List<TransactionModel> txns;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: txns.length,
      itemBuilder: (context, index) {
        final txn = txns[index];
        final isSend = txn.type.toLowerCase() == 'send';
        final amountText =
            '${isSend ? '+' : '-'}KES${txn.amount.toStringAsFixed(2)}';
        final amountColor = isSend
            ? kReceivedTransactionColor
            : kSentTransactionColor;
        final formattedDate = DateFormat(
          'dd-MM-yyyy h:mma',
        ).format(txn.date);
    
        return ListTile(
          // 1. User avatar
          leading: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Text(
              txn.counterparty.isNotEmpty
                  ? txn.counterparty[0].toUpperCase()
                  : '?',
            ),
          ),
          
          // 2. User's name
          title: Text(txn.counterparty),
          
          // 3. Transaction type
          subtitle: Text(
            isSend ? 'Received money' : 'Sent money',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: kTextSecondaryColor,
              fontSize: 12.0,
            ),
          ),

          // 4. Transaction date and amount
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                amountText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: amountColor,
                  fontSize: 16.0,
                ),
              ),
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: kTextSecondaryColor,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
