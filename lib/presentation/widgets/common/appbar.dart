import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final bool? centerTitle;
  final Color? appBgColor;
  final TextStyle? appBarTitleStyle;
  final bool
  showGoBackToPreviousScreenBtn; // show icon button to navigate back to previous screen
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    this.showGoBackToPreviousScreenBtn = true,
    this.actions,
    this.appBgColor,
    this.appBarTitleStyle,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showGoBackToPreviousScreenBtn
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(CupertinoIcons.back),
            )
          : null,
      automaticallyImplyLeading: showGoBackToPreviousScreenBtn,
      backgroundColor: appBgColor,
      centerTitle: centerTitle,

      title: Text(
        appBarTitle,
        style: appBarTitleStyle ?? Theme.of(context).textTheme.titleMedium,
      ),

      actions: actions,
    );
  }
}
