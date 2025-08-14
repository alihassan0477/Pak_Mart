class Review {
  Review(
      {required this.customer_name,
      required this.description,
      required this.rating});

  String? customer_name;
  String description;
  int rating;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        customer_name: json["customer_id"]['username'] ?? "null",
        description: json['description'],
        rating: json['rating']);
  }

  Map<String, dynamic> toJson(String customerId, String productId) {
    return {
      "customer_id": customerId,
      "product_id": productId,
      "rating": rating,
      "description": description
    };
  }
}
