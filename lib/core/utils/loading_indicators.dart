import 'package:flutter/cupertino.dart';

class AppLoadingIndicators {
  static Widget loadingIndicatorExtraSmall() {
    return CupertinoActivityIndicator(radius: 8.0);
  }

  static Widget loadingIndicatorSmall() {
    return CupertinoActivityIndicator(radius: 12.0);
  }

  static Widget loadingIndicatorMedium() {
    return CupertinoActivityIndicator(radius: 16.0);
  }

  static Widget loadingIndicatorLarge() {
    return CupertinoActivityIndicator(radius: 32.0);
  }
}