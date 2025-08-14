import 'dart:convert';

import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:pakmart/SellerCentral/data/network/network_services.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

import '../../../Model/CategoryModel.dart';

abstract class ProductRepository {
  Future<List<Category>> fetchCategories();
  Future<List<Product>> fetchSellerProducts();
  Future<String> deleteSellerProductById(String productId);
  Future<void> createProduct(
    String name,
    String category,
    int price,
    int stock,
    String description,
    List<String> images,
  );
}

class HttpProductRepo implements ProductRepository {
  NetworkServicesApi networkServicesApi = NetworkServicesApi();

  @override
  Future<List<Category>> fetchCategories() async {
    final response = await networkServicesApi.getApi(AppUrl.FETCH_CATEGORIES);

    final List jsonCategories = response['categories'];

    return jsonCategories
        .map<Category>((jsonObj) => Category.fromJson(jsonObj))
        .toList();
  }

  @override
  Future<List<Product>> fetchSellerProducts() async {
    final sellerId = SellerSessionController().seller_id;
    print("Seller ID: $sellerId");
    final url = AppUrl.getSellerIdUrl(sellerId);

    final List response = await networkServicesApi.getApi(url);

    return response.map((jsonObj) => Product.fromJson(jsonObj)).toList();
  }

  @override
  Future<String> deleteSellerProductById(String productId) async {
    final sellerId = SellerSessionController().seller_id;
    final url = AppUrl.productDeleteUrl(productId, sellerId);

    final response = await networkServicesApi.deleteApi(url);

    return response['message'];
  }

  @override
  Future<dynamic> createProduct(
    String name,
    String category,
    int price,
    int stock,
    String description,
    List<String> images,
  ) async {
    final sellerId = SellerSessionController().seller_id;
    const url = AppUrl.CREATE_PRODUCT;
    final data = {
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      'description': description,
      'seller': sellerId, // Use seller ID instead of the entire seller object
      'images': images,
      "specifications": [
        {"key": "Color", "value": "Red"},
      ],
    };

    final response = await networkServicesApi.postApi(url, data);

    return response;
  }
}
