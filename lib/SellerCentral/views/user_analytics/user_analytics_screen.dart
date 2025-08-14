import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/user-analytics/bloc/user_analytics_bloc.dart';
import 'package:pakmart/SellerCentral/views/user_analytics/widget/analytic_data_widget.dart';

import 'package:pakmart/main.dart';

class UserAnalyticsScreen extends StatefulWidget {
  const UserAnalyticsScreen({super.key});

  @override
  State<UserAnalyticsScreen> createState() => _UserAnalyticsScreenState();
}

class _UserAnalyticsScreenState extends State<UserAnalyticsScreen> {
  late UserAnalyticsBloc _userAnalyticsBloc;

  @override
  void initState() {
    super.initState();
    _userAnalyticsBloc = UserAnalyticsBloc(getIt());
  }

  @override
  void dispose() {
    _userAnalyticsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Analytics")),
      body: BlocProvider(
        create:
            (context) =>
                _userAnalyticsBloc..add(const StartPollingUserAnalyticsEvent()),
        child: const AnalyticDataWidget(),
      ),
    );
  }
}
