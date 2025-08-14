import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_event.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_state.dart';

import 'package:pakmart/SellerCentral/config/components/status_button.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';
import 'package:pakmart/SellerCentral/utils/utlis.dart';
import 'package:pakmart/main.dart';

class StatusButtons extends StatefulWidget {
  const StatusButtons({super.key, required this.rfqId});

  final String rfqId;

  @override
  State<StatusButtons> createState() => _StatusButtonsState();
}

class _StatusButtonsState extends State<StatusButtons> {
  late ReceiveLeadsBloc _receiveLeadsBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _receiveLeadsBloc = ReceiveLeadsBloc(getIt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _receiveLeadsBloc,
      child: BlocConsumer<ReceiveLeadsBloc, ReceiveLeadsState>(
        listenWhen:
            (previous, current) =>
                previous.updateApiStatus != current.updateApiStatus,
        listener: (context, state) {
          if (state.updateApiStatus == UpdateApiStatus.successful) {
            Utlis.showSnackBar(context, "Status updated successfully");

            Navigator.pop(context, true);
          } else if (state.updateApiStatus == UpdateApiStatus.error) {
            Utlis.showSnackBar(context, "Error updating status");
          }
        },
        buildWhen:
            (previous, current) =>
                previous.updateApiStatus != current.updateApiStatus,
        builder: (context, state) {
          switch (state.updateApiStatus) {
            case UpdateApiStatus.initial:
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusButton(
                    label: 'OrderReceived',
                    color: Colors.green,
                    onPressed: () {
                      context.read<ReceiveLeadsBloc>().add(
                        UpdateLeadStatusEvent(
                          rfqId: widget.rfqId,
                          status: 'OrderReceived',
                        ),
                      );
                    },
                  ),
                  StatusButton(
                    label: 'OrderClosed',
                    color: Colors.blue,
                    onPressed: () {
                      context.read<ReceiveLeadsBloc>().add(
                        UpdateLeadStatusEvent(
                          rfqId: widget.rfqId,
                          status: 'OrderClosed',
                        ),
                      );
                    },
                  ),
                  StatusButton(
                    label: 'LeadRejected',
                    color: Colors.red,
                    onPressed: () {
                      context.read<ReceiveLeadsBloc>().add(
                        UpdateLeadStatusEvent(
                          rfqId: widget.rfqId,
                          status: 'LeadRejected',
                        ),
                      );
                    },
                  ),
                ],
              );
            case UpdateApiStatus.updating:
              return const Center(child: CircularProgressIndicator());
            case UpdateApiStatus.error:
              return const Center(child: Text("Error"));
            default:
              return const Center(child: Text("Unknown Status"));
          }
        },
      ),
    );
  }
}
