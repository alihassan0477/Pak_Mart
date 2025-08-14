import 'package:flutter/material.dart';

class Utlis {
  static void showButtomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.bounceInOut,
        duration: const Duration(seconds: 1),
      ),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  static Future<dynamic> showBottomSheetReturnValue(
    BuildContext context,
    Widget widget,
  ) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.bounceInOut,
        duration: const Duration(seconds: 1),
      ),
      builder: (BuildContext context) {
        return widget;
      },
    );

    return result;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void alertDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(title), content: Text(content));
      },
    );
  }
}
