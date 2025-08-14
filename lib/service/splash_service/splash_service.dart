import 'package:flutter/material.dart';
import 'package:pakmart/SellerCentral/views/dashboard/dashboard_screen.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/started/gettingStarted.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

class SplashService {
  Future<void> splashService(BuildContext context) async {
    await SellerSessionController().getSellerPrefs();

    if (SellerSessionController().isLogin) {
      context.navigateTo(const DashboardScreen());
    } else {
      context.navigateTo(const GettingStartedScreen());
    }
  }
}
