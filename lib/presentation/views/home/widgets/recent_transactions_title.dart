import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class RecentTransactionsTitle extends StatelessWidget {
  const RecentTransactionsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Transactions',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: kTextSecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Row(
            children: [
              Text(
                'See all',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: kHyperLinkTextColor),
              ),
              SizedBox(width: 4.0),
              Icon(CupertinoIcons.chevron_right, size: 12.0),
            ],
          ),
        ],
      ),
    );
  }
}
