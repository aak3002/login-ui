import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelpers {
  AppHelpers._();

  static void
      hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void focusNextField(
      FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(currentFocus.context!).requestFocus(nextFocus);
  }

  static void
      unfocusAll() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static Timer?
      _debounceTimer;

  static void debounce(
      Duration duration,
      Function() callback) {
    _debounceTimer?.cancel();
    _debounceTimer =
        Timer(duration, callback);
  }

  static String
      formatPhoneNumber(String phone) {
    String
        cleaned =
        phone.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleaned.startsWith('+971')) {
      if (cleaned.length >= 13) {
        return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6, 9)} ${cleaned.substring(9)}';
      }
    }

    return phone;
  }

  static List<String>
      getOTPPlaceholders(int length) {
    return List.generate(length,
        (index) => '');
  }

  static bool
      isOTPComplete(List<String> otpValues) {
    return otpValues.every((value) =>
        value.isNotEmpty);
  }

  static String
      getOTPString(List<String> otpValues) {
    return otpValues.join();
  }

  static void
      moveToNextOTPField({
    required String
        value,
    required int
        currentIndex,
    required List<FocusNode>
        focusNodes,
    required int
        maxLength,
  }) {
    if (value.isNotEmpty &&
        currentIndex < maxLength - 1) {
      focusNodes[currentIndex + 1].requestFocus();
    } else if (value.isEmpty && currentIndex > 0) {
      focusNodes[currentIndex - 1].requestFocus();
    }
  }

  static void showLoading(
      BuildContext context,
      {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  static void
      hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
