import 'dart:convert';
import 'package:pakmart/Model/SellerModel.dart';

class Product {
  String? id;
  String name;
  String category;
  int price;
  int stock;
  String description;
  Seller seller; // Seller is now a reference to the Seller model
  List<String> images;
  List<Specifications> specifications;

  // Constructor
  Product(
      {this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.stock,
      required this.description,
      required this.seller,
      required this.images,
      required this.specifications});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      category: json['category']?['name'] ?? 'Unknown',
      price: json['price'],
      stock: json['stock'],
      description: json['description'],
      seller: json['seller'] != null
          ? Seller.fromJson(json['seller'])
          : throw Exception("Seller data is null"),
      images: List<String>.from(json['images'] ?? []),
      specifications: (json['specifications'] != null)
          ? (json['specifications'] as List)
              .map((spec) => Specifications.fromJson(spec))
              .toList()
          : [],
    );
  }

  // Method to convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      'description': description,
      'seller': seller.toJson(), // Convert seller object to JSON
      'images': images,
    };
  }
}

class Specifications {
  Specifications({required this.key, required this.value});
  String key;
  String value;

  factory Specifications.fromJson(Map<String, dynamic> json) {
    return Specifications(
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }
}
