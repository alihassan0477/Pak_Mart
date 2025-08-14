import 'package:flutter/material.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/started/gettingStarted.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

class LogoutService {
  void logoutService(BuildContext context) async {
    await SellerSessionController().clearSellerPrefs().then(
      (value) {
        context.navigateTo(const GettingStartedScreen());
      },
    );
  }
}
