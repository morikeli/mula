import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

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
