import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pakmart/SellerCentral/repository/product/product_repository.dart';
import 'package:pakmart/SellerCentral/repository/received_leads.dart/receive_leads_repo.dart';
import 'package:pakmart/SellerCentral/repository/user-anaytics/repo/user_analytics_repo.dart';
import 'package:pakmart/screens/splash_screen/splash_screen.dart';
import 'package:pakmart/screens/started/gettingStarted.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ProductRepository>(() => HttpProductRepo());
  getIt.registerLazySingleton<ReceiveLeadsRepository>(
    () => ReceiveLeadsHttpRepository(),
  );
  getIt.registerLazySingleton<UserAnalyticsRepo>(() => UserAnalyticsRepoHttp());
}

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
