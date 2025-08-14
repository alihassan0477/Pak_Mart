import 'package:equatable/equatable.dart';

abstract class ReceiveLeadsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchReceivedLeadsEvent extends ReceiveLeadsEvent {
  @override
  List<Object> get props => [];
}

class UpdateLeadStatusEvent extends ReceiveLeadsEvent {
  final String rfqId;
  final String status;

  UpdateLeadStatusEvent({required this.rfqId, required this.status});

  @override
  List<Object> get props => [rfqId, status];
}
