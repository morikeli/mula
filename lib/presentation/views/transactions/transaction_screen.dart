import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_toasts.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/forms/transaction_form.dart';

class TransactionScreen extends StatelessWidget {
  static String routeName = '/send-money';
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Send money'),
      body: BlocConsumer<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          if (state is TransactionFailed) {
            AppToast.showError(context, title: 'Transaction error!', message: state.errorMessage.toString());
          } else if (state is TransactionSuccess) {
            AppToast.showSuccess(context, title: 'Money sent successfully!');
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: TransactionForm(),
          );
        },
      ),
    );
  }
}
