import 'package:flutter/material.dart';

class AppNavigator {
  static navigateAndFinish(
      {required BuildContext context, required String screen}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(screen, (Route<dynamic> route) => false);
  }

  static navigateBack({required BuildContext context}) {
    Navigator.canPop(context) ? Navigator.pop(context) : null;
  }

  static navigateTo(
      {required BuildContext context,
      required String screen,
      Object? arguments}) {
    Navigator.pushNamed(context, screen, arguments: arguments);
  }

  static navigateAndReplace(
      {required BuildContext context,
      required String screen,
      Object? arguments}) {
    Navigator.pushReplacementNamed(context, screen, arguments: arguments);
  }
}
