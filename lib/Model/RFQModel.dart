class RFQ {
  RFQ({
    this.rfqId,
    required this.title,
    required this.Location,
    required this.customTitle,
    required this.customerId,
    required this.productRequired,
    required this.deliveryTime,
    required this.quantity,
    this.status,
  });
  String? rfqId;
  String title;
  String customTitle;
  String productRequired;
  int quantity;
  String deliveryTime;
  String Location;
  String customerId;
  String? status;

  factory RFQ.fromJson(Map<String, dynamic> json) {
    return RFQ(
      rfqId: json['_id'] ?? '',
      title: json['title'] ?? '',
      customTitle: json['custom_title'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      productRequired: json['productname'] ?? '',
      quantity: json['quantity'] ?? 0,
      Location: json['Location'] ?? '',
      customerId: json['customer_id'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "custom_title": customTitle,
      "deliveryTime": deliveryTime,
      "productname": productRequired,
      "quantity": quantity,
      "Location": Location,
      "customer_id": customerId,
    };
  }
}
