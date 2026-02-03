import 'package:flutter/material.dart';

import '../../widgets/common/appbar.dart';
import '../../widgets/forms/transaction_form.dart';

class TransactionScreen extends StatelessWidget {
  static String routeName = '/send-money';
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Send money',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: TransactionForm(),
      ),
    );
  }
}