import 'package:equatable/equatable.dart';
import 'package:pakmart/Model/RFQModel.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';

class ReceiveLeadsState extends Equatable {
  const ReceiveLeadsState({
    this.updateApiStatus = UpdateApiStatus.initial,
    this.totalLeadsCount = 0,
    this.getApiStatus = GetApiStatus.loading,
    this.receivedLeads = const [],
  });
  final int totalLeadsCount;
  final GetApiStatus getApiStatus;
  final List<RFQ> receivedLeads;
  final UpdateApiStatus updateApiStatus;

  ReceiveLeadsState copyWith({
    int? totalLeadsCount,
    GetApiStatus? getApiStatus,
    List<RFQ>? receivedLeads,
    UpdateApiStatus? updateApiStatus,
  }) {
    return ReceiveLeadsState(
      totalLeadsCount: totalLeadsCount ?? this.totalLeadsCount,
      getApiStatus: getApiStatus ?? this.getApiStatus,
      receivedLeads: receivedLeads ?? this.receivedLeads,
      updateApiStatus: updateApiStatus ?? this.updateApiStatus,
    );
  }

  @override
  List<Object> get props => [
    totalLeadsCount,
    getApiStatus,
    receivedLeads,
    updateApiStatus,
  ];
}
