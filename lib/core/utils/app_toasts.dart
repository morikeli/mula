import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: const Duration(seconds: 5),
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
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: const Duration(seconds: 7),
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
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: const Duration(seconds: 5),
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
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }
}