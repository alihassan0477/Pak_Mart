class UserAnalyticsModel {
  final int freshLeads;
  final int orderReceived;
  final int orderClosed;
  final int leadsRejected;

  UserAnalyticsModel({
    required this.freshLeads,
    required this.orderReceived,
    required this.orderClosed,
    required this.leadsRejected,
  });

  factory UserAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return UserAnalyticsModel(
      freshLeads: json['FreshLead'] ?? 0,
      orderReceived: json['OrderReceived'] ?? 0,
      orderClosed: json['OrderClosed'] ?? 0,
      leadsRejected: json['LeadRejected'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'FreshLead': freshLeads,
      'OrderReceived': orderReceived,
      'OrderClosed': orderClosed,
      'LeadRejected': leadsRejected,
    };
  }
}
