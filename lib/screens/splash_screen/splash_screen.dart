import 'package:flutter/material.dart';
import 'package:pakmart/service/splash_service/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashService();
  }

  void _splashService() async {
    await SplashService().splashService(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
