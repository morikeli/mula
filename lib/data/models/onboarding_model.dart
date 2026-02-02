import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class OnboardingItem {
  final Icon icon;
  final String title;
  final String description;

  OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

final onboardingItems = [
  OnboardingItem(
    icon: Icon(CupertinoIcons.creditcard, color: kIconDarkColor, size: 52.0),
    title: 'Direct Pay',
    description: 'Send money across the world effortlessly.',
  ),
  OnboardingItem(
    icon: Icon(Icons.account_balance_wallet, color: kIconDarkColor, size: 52.0),
    title: 'Receive Payments',
    description: 'Receive payments hassle-free without any transaction fees.',
  ),
  OnboardingItem(
    icon: Icon(CupertinoIcons.tickets_fill, color: kIconDarkColor, size: 52.0),
    title: 'Pay Bills and Services',
    description: 'Pay for utility services and earn rewards!',
  ),
];
