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

          return BottomBar(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or email',
                  prefixIcon: Icon(CupertinoIcons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  context.read<ProfileBloc>().add(SearchUsers(value));
                },
              ),
            ),
            body: (context, controller) {
              if (state is UserSearchLoaded) {
                if (state.users.isEmpty) {
                  return TransactionScreenErrorWidget();
                }

                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${user.firstName?[0]}'),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                      onTap: () {
                        searchController.clear();
                        Navigator.pushNamed(
                          context,
                          '/send-money',
                          arguments: user.email,
                        );
                      },
                    );
                  },
                );
              }

              return TransactionScreenErrorWidget();
            },
          );
        },
      ),
    );
  }
}
