import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static void showError(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
    bool? pauseOnHover = true,
    bool? showProgressBar = true,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: pauseOnHover,
      showProgressBar: showProgressBar,
    );
  }
}