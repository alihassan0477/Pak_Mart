import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pakmart/Model/RFQModel.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_event.dart';
import 'package:pakmart/SellerCentral/bloc/ReceivedLeads/bloc/receive_leads_dart_state.dart';

import 'package:pakmart/SellerCentral/repository/received_leads.dart/receive_leads_repo.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';

class ReceiveLeadsBloc extends Bloc<ReceiveLeadsEvent, ReceiveLeadsState> {
  ReceiveLeadsRepository receiveLeadsRepository;
  ReceiveLeadsBloc(this.receiveLeadsRepository)
    : super(const ReceiveLeadsState()) {
    on<FetchReceivedLeadsEvent>(_fetchReceivedLeadsEvent);
    on<UpdateLeadStatusEvent>(_updateLeadStatusEvent);
  }

  void _fetchReceivedLeadsEvent(
    FetchReceivedLeadsEvent event,
    Emitter<ReceiveLeadsState> emit,
  ) async {
    emit(state.copyWith(getApiStatus: GetApiStatus.loading));

    await receiveLeadsRepository
        .fetchReceivedLeads()
        .then((List<RFQ> leads) {
          emit(
            state.copyWith(
              totalLeadsCount: leads.length,
              getApiStatus: GetApiStatus.completed,
              receivedLeads: leads,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(getApiStatus: GetApiStatus.error));
        });
  }

  void _updateLeadStatusEvent(
    UpdateLeadStatusEvent event,
    Emitter<ReceiveLeadsState> emit,
  ) async {
    emit(state.copyWith(updateApiStatus: UpdateApiStatus.updating));

    await receiveLeadsRepository
        .updateLeadStatus(event.rfqId, event.status)
        .then((String message) {
          if (message == "Status updated successfully") {
            add(FetchReceivedLeadsEvent());
            emit(state.copyWith(updateApiStatus: UpdateApiStatus.successful));
          } else {
            emit(state.copyWith(updateApiStatus: UpdateApiStatus.error));
          }
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(updateApiStatus: UpdateApiStatus.error));
        });

    emit(state.copyWith(updateApiStatus: UpdateApiStatus.initial));
  }
}
