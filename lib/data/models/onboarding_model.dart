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

  OnboardingItem(
    icon: Icon(CupertinoIcons.lock_shield_fill, color: kIconDarkColor, size: 52.0),
    title: 'Secure Wallet',
    description:
        'Your funds are secured with top-level encryption and security.',
  ),

  OnboardingItem(
    icon: Icon(
      CupertinoIcons.chart_bar_alt_fill,
      color: kIconDarkColor,
      size: 52.0,
    ),
    title: 'Track Your Spending',
    description: 'Monitor your expenses and manage your finances smarter.',
  ),

  OnboardingItem(
    icon: Icon(
      CupertinoIcons.person_crop_circle_badge_checkmark,
      color: kIconDarkColor,
      size: 52.0,
    ),
    title: 'Verified Accounts',
    description: 'Enjoy safe transactions with trusted and verified users.',
  ),

  OnboardingItem(
    icon: Icon(CupertinoIcons.headphones, color: kIconDarkColor, size: 52.0),
    title: '24/7 Support',
    description: 'Get help anytime from our dedicated customer support team.',
  ),
];
