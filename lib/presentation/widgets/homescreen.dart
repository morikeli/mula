import 'package:flutter/material.dart';

import '../views/home/home.dart';
import '../views/transactions/transaction_history_screen.dart';
import 'custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  final List<Widget> screens = [Home(), TransactionHistoryScreen()];

  void moveToSelectedScreen(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: CustomBottomNavBar(
        onTabClicked: (index) => moveToSelectedScreen(index),
        activeTab: screenIndex,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
