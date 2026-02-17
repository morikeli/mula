import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';

class UsernameAndLocation extends StatelessWidget {
  const UsernameAndLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = 'User';
        if (state is IsAuthenticated) {
          final user = state.user;
          name = user.firstName ?? user.email.split('@').first;
        }

        return Center(
          child: Column(
            children: [
              Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: 28.0),
              ),
              Text(
                'Nairobi, Kenya',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: kTextSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

