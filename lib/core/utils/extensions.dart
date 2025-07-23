import 'package:flutter/material.dart';

extension StringExtension
    on String {
  String
      get capitalize {
    if (isEmpty)
      return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String
      get removeWhitespace {
    return replaceAll(RegExp(r'\s+'),
        '');
  }

  bool
      get isValidEmail {
    const pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(pattern).hasMatch(this);
  }

  bool
      get isValidPhone {
    String
        cleanPhone =
        replaceAll(RegExp(r'[^0-9+]'), '');
    return cleanPhone.length >=
        10;
  }

  String
      get formatPhoneDisplay {
    if (length >=
        10) {
      return '${substring(0, 3)} ${substring(3, 6)} ${substring(6)}';
    }
    return this;
  }
}

extension ContextExtension
    on BuildContext {
  double get screenWidth => MediaQuery.of(this)
      .size
      .width;
  double get screenHeight => MediaQuery.of(this)
      .size
      .height;

  void pushNamed(
      String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(this,
        routeName,
        arguments: arguments);
  }

  void pushReplacementNamed(
      String routeName,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(this,
        routeName,
        arguments: arguments);
  }

  void
      pop() {
    Navigator.pop(this);
  }

  ThemeData get theme =>
      Theme.of(this);
  TextTheme get textTheme =>
      Theme.of(this).textTheme;
  ColorScheme get colorScheme =>
      Theme.of(this).colorScheme;

  void showSnackBar(
      String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension ListExtension<T>
    on List<T> {
  bool get isNullOrEmpty =>
      isEmpty;

  T? getOrNull(
      int index) {
    if (index >= 0 &&
        index < length) {
      return this[index];
    }
    return null;
  }
}
