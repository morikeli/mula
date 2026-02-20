import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/loading_indicators.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../widgets/common/appbar.dart';

class TransactionScreen extends StatelessWidget {
  static String routeName = '/transaction-screen';
  TransactionScreen({super.key});
  final TextEditingController searchController = TextEditingController();

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

class TransactionScreenErrorWidget extends StatelessWidget {
  const TransactionScreenErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.32),
        Icon(
          CupertinoIcons.person_crop_circle_fill_badge_xmark,
          size: 48.0,
          color: kIconLightColor,
        ),
        SizedBox(height: 12.0),
        Center(child: Text('No user found')),
      ],
    );
  }
}
