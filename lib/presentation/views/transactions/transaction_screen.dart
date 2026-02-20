import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_toasts.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/forms/transaction_form.dart';

class TransactionScreen extends StatelessWidget {
  static String routeName = '/send-money';
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Search for users'),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserSearchLoading) {
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
