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
                child: Center(
                  child: Text(
                    'No recent transactions',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: kTextSecondaryColor),
                  ),
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

class RecentTransactionsListTiles extends StatelessWidget {
  const RecentTransactionsListTiles({
    super.key,
    required this.txns,
  });

  final List<TransactionModel> txns;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: txns.length,
      itemBuilder: (context, index) {
        final txn = txns[index];
        final isSend = txn.type.toLowerCase() == 'send';
        final amountText =
            '${isSend ? '-' : ''}\$${txn.amount.toStringAsFixed(2)}';
        final amountColor = isSend
            ? kSentTransactionColor
            : kReceivedTransactionColor;
        final formattedDate = DateFormat(
          'dd-MM-yyyy h:mma',
        ).format(txn.date);
    
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              txn.counterparty.isNotEmpty
                  ? txn.counterparty[0].toUpperCase()
                  : '?',
            ),
          ),
          title: Text(txn.counterparty),
          subtitle: Text(
            isSend ? 'Sent money' : 'Received money',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: kTextSecondaryColor,
              fontSize: 12.0,
            ),
          ),
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

class WalletAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const WalletAction({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24.0,
          backgroundColor: kCircleAvatarBgColor,
          child: Icon(icon, color: Colors.white, size: 20.0),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12.0),
        ),
      ],
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          colors: kWalletCardGradientColor,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row (Wallet title)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.creditcard),
                  SizedBox(width: 8.0),
                  const Text(
                    "Your wallet balance",
                    style: TextStyle(color: kTextLightColor, fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 4.0),

          // Balance Amount + QR Code icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BlocBuilder<TransactionsBloc, TransactionsState>(
                    builder: (context, state) {
                      final repo = RepositoryProvider.of<TransactionRepository>(
                        context,
                      );
                      String? uid;
                      final authState = context.read<AuthBloc>().state;
                      if (authState is IsAuthenticated) {
                        uid = authState.user.uid;
                      }

                      return FutureBuilder<double>(
                        future: uid != null
                            ? repo.transactionService.getWalletBalance(uid)
                            : Future.value(0.0),
                        builder: (context, snap) {
                          final formatted = snap.hasData
                              ? NumberFormat('#,##0.00').format(snap.data)
                              : '--';
                          return Text(
                            "KES $formatted",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.eye)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  CupertinoIcons.qrcode,
                  color: Colors.white,
                  size: 44.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Action Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              WalletAction(icon: CupertinoIcons.money_dollar, label: "Balance"),
              WalletAction(icon: CupertinoIcons.creditcard, label: "Deposit"),
              WalletAction(
                icon: CupertinoIcons.arrow_2_circlepath_circle,
                label: "Send",
              ),
              WalletAction(
                icon: CupertinoIcons.arrow_down_circle,
                label: "Receive",
              ),
              WalletAction(icon: CupertinoIcons.clock, label: "History"),
            ],
          ),
        ],
      ),
    );
  }
}

class UserAvatarAndGreetings extends StatelessWidget {
  const UserAvatarAndGreetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: MediaQuery.of(context).size.width * .06,
          backgroundImage: AssetImage(kFemaleProfilePicture),
        ),
        minLeadingWidth: 2.0,
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String name = 'User';
            if (state is IsAuthenticated) {
              final user = state.user;
              name = user.firstName ?? user.email.split('@').first;
            }
            return Text(
              'Hello $name,',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 16.0),
            );
          },
        ),
        subtitle: Text(
          'Welcome back!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(CupertinoIcons.bell),
      ),
    );
  }
}
