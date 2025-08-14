import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pakmart/Model/ReviewModel.dart';
import 'package:pakmart/constant/baseUrl.dart';

class ReviewsApi {
  Future<List<Review>> get_Reviews_by_productId(String productId) async {
    final url = Uri.parse("$baseUrl/api/get-Review-by-productId/$productId");

    try {
      final response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;

        return jsonData
            .map(
              (jsonReview) => Review.fromJson(jsonReview),
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

  Future<String> sendReview(Review review, String customerId, productId) async {
    final url = Uri.parse('$baseUrl/api/create-review');
    final headers = {'Content-Type': 'application/json'};
    final body = review.toJson(customerId, productId);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Review Created Succesfully";
      } else {
        return "Review not created";
      }
    } catch (e) {
      print(e);
      return "Some internal error occured";
    }
  }
}
