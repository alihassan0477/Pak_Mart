import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/user-analytics/bloc/user_analytics_bloc.dart';
import 'package:pakmart/SellerCentral/config/components/stat_card.dart';

class AnalyticDataWidget extends StatelessWidget {
  const AnalyticDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAnalyticsBloc, UserAnalyticsState>(
      buildWhen:
          (previous, current) =>
              previous.userAnalyticsModel != current.userAnalyticsModel ||
              previous.error != current.error,
      builder: (context, state) {
        return state.error.isNotEmpty
            ? Center(child: Text(state.error))
            : GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                StatCard(
                  icon: Icons.access_time,
                  iconBackgroundColor: Colors.orange,
                  value: state.userAnalyticsModel.freshLeads.toString(),
                  label: 'Fresh Lead',
                ),
                StatCard(
                  icon: Icons.check_circle,
                  iconBackgroundColor: Colors.teal,
                  value: state.userAnalyticsModel.orderReceived.toString(),
                  label: 'Order Received',
                ),
                StatCard(
                  icon: Icons.check_circle_outline,
                  iconBackgroundColor: Colors.green,
                  value: state.userAnalyticsModel.orderClosed.toString(),
                  label: 'Order Closed',
                ),
                StatCard(
                  icon: Icons.cancel,
                  iconBackgroundColor: Colors.red,
                  value: state.userAnalyticsModel.leadsRejected.toString(),
                  label: 'Leads Rejected',
                ),
              ],
            );
      },
    );
  }
}
