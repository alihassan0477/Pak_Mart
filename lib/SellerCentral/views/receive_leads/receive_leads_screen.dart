import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_event.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_state.dart';

import 'package:pakmart/SellerCentral/utils/enums.dart';
import 'package:pakmart/SellerCentral/utils/utlis.dart';
import 'package:pakmart/SellerCentral/views/receive_leads/widgets/lead_details_bottom_sheet_widget.dart';
import 'package:pakmart/main.dart';

class ReceiveLeadsScreen extends StatefulWidget {
  const ReceiveLeadsScreen({super.key});

  @override
  State<ReceiveLeadsScreen> createState() => _ReceiveLeadsScreenState();
}

class _ReceiveLeadsScreenState extends State<ReceiveLeadsScreen> {
  late ReceiveLeadsBloc _receiveLeadsBloc;

  @override
  void initState() {
    super.initState();
    _receiveLeadsBloc = ReceiveLeadsBloc(getIt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _receiveLeadsBloc..add(FetchReceivedLeadsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ReceiveLeadsBloc, ReceiveLeadsState>(
            buildWhen:
                (previous, current) =>
                    previous.totalLeadsCount != current.totalLeadsCount,
            builder: (context, state) {
              return Text("Receive Leads (${state.totalLeadsCount})");
            },
          ),
        ),
        body: BlocBuilder<ReceiveLeadsBloc, ReceiveLeadsState>(
          buildWhen:
              (previous, current) =>
                  previous.receivedLeads != current.receivedLeads ||
                  previous.getApiStatus != current.getApiStatus,
          builder: (context, state) {
            switch (state.getApiStatus) {
              case GetApiStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case GetApiStatus.completed:
                return state.receivedLeads.isEmpty
                    ? const Center(child: Text("No Leads Found"))
                    : ListView.builder(
                      itemCount: state.receivedLeads.length,
                      itemBuilder: (context, index) {
                        final lead = state.receivedLeads[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () async {
                              final result =
                                  await Utlis.showBottomSheetReturnValue(
                                    context,
                                    LeadDetailsWidget(lead: lead),
                                  );

                              if (result == true) {
                                context.read<ReceiveLeadsBloc>().add(
                                  FetchReceivedLeadsEvent(),
                                );
                              }
                            },
                            tileColor: Colors.green[50],
                            title: Text(lead.title),
                            subtitle: Text(lead.rfqId ?? ''),
                            trailing: Text(lead.status ?? ''),
                          ),
                        );
                      },
                    );
              case GetApiStatus.error:
                return const Center(child: Text("Error Occurred"));
            }
          },
        ),
      ),
    );
  }
}
