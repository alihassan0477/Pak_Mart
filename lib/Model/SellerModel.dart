import 'dart:convert';

class Seller {
  String? id;
  String name;
  String email;
  String phoneNo;
  String cnic;
  String residentialAddress;
  String storeName;

  // Constructor
  Seller({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.cnic,
    required this.residentialAddress,
    required this.storeName,
  });

  // Factory method to create a Seller from JSON
  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['_id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNo: json['phoneNo'] as String,
      cnic: json['CNIC'] as String,
      residentialAddress: json['residentialAdress'] as String,
      storeName: json['storeName'] as String,
    );
  }

  // Method to convert Seller to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'CNIC': cnic,
      'residentialAdress': residentialAddress,
      'storeName': storeName,
    };
  }

  Map<String, dynamic> toJsonWithPassword(String password) {
    return {
      '_id': id,
      'name': name,
      'email': email,
      "password": password,
      'phoneNo': phoneNo,
      'CNIC': cnic,
      'residentialAdress': residentialAddress,
      'storeName': storeName,
    };
  }
}
