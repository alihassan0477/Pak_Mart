import 'dart:convert';
import 'package:pakmart/Model/CategoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:pakmart/constant/baseUrl.dart';

class CategoryApi {
  static Future<List<Category>> getRootCategories() async {
    final url = Uri.parse('$baseUrl/api/categories/root');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> categoryJson = json.decode(response.body);

        return categoryJson.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load products: $e');
    }
  }

  static Future<List<Category>> getSubCategories(String parentId) async {
    final url = Uri.parse('$baseUrl/api/subCategories/$parentId');

    try {
      final response = await http.get(url);

      final List<dynamic> subcategoriesjson = json.decode(response.body);

      if (response.statusCode == 200) {
        List<Category> subcategories = subcategoriesjson
            .map(
              (json) => Category.fromJson(json),
            )
            .toList();

        return subcategories;
      } else {
        throw Exception('Failed to load subCategories ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
