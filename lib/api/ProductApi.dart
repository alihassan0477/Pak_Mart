import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/constant/baseUrl.dart';

class ProductApi {
  Future<List<Product>> getProductsByCategory(String category) async {
    final url = Uri.parse('$baseUrl/api/get-product-by-category/$category');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> productJson =
            json.decode(response.body)['products'];

        print(productJson);

        // productJson.map((json) => Product(name: json['name'], category: category, price: price, stock: stock, description: description, seller: seller, images: images, specifications: specifications),)

        return productJson.map((json) => Product.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> get_all_products() async {
    final url = Uri.parse("$baseUrl/api/get-all-products");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> product = jsonDecode(response.body);

        print(product);

        return product
            .map(
              (json) => Product.fromJson(json),
            )
            .toList();
      } else {
        print("Some error occured");
        return [];
      }
    } catch (error) {
      print("Some internal error occured");
      return [];
    }
  }
}
