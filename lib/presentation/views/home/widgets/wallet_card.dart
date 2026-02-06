import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/colors.dart';
import '../../../cubits/wallet/wallet_balance_cubit.dart';
import '../../../cubits/wallet/wallet_visibility_cubit.dart';
import 'wallet_action_btns.dart';

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
          WalletTitle(),
          const SizedBox(height: 4.0),
          // Balance Amount + QR Code icon
          WalletBalance(),
          const SizedBox(height: 16.0),
          // Action Buttons Row - balance, deposit, send, etc
          ActionButtons(),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        WalletAction(icon: CupertinoIcons.money_dollar, label: "Balance"),
        WalletAction(icon: CupertinoIcons.creditcard, label: "Deposit"),
        WalletAction(
          icon: CupertinoIcons.arrow_2_circlepath_circle,
          label: "Send",
        ),
        WalletAction(icon: CupertinoIcons.arrow_down_circle, label: "Receive"),
        WalletAction(icon: CupertinoIcons.clock, label: "History"),
      ],
    );
  }
}

class WalletBalance extends StatelessWidget {
  const WalletBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WalletBalanceText(),
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
    );
  }
}

class WalletBalanceText extends StatelessWidget {
  const WalletBalanceText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<WalletVisibilityCubit, bool>(
          builder: (context, isVisible) {
            return BlocBuilder<WalletBalanceCubit, double>(
              builder: (context, balance) {
                final walletBal = NumberFormat().format(balance);
                return Text(
                  isVisible ? "KES $walletBal" : "*******",
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
        IconButton(
          onPressed: () {
            context.read<WalletVisibilityCubit>().toggle();
          },
          icon: BlocBuilder<WalletVisibilityCubit, bool>(
            builder: (context, isVisible) {
              return Icon(
                isVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              );
            },
          ),
        ),
      ],
    );
  }
}

class WalletTitle extends StatelessWidget {
  const WalletTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
