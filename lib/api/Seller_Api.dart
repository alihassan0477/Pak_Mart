import 'dart:convert';

import 'package:pakmart/Model/SellerModel.dart';
import 'package:pakmart/constant/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:pakmart/service/session_manager/session_controller.dart';

class SellerApi {
  Future<int> signUp(Seller seller, String password) async {
    const url = '$baseUrl/api/create-seller';

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(seller.toJsonWithPassword(password)));

      print(response.statusCode);

      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 400) {
        return 400;
      } else if (response.statusCode == 401) {
        return 401;
      } else {
        return 500;
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create seller');
    }
  }

  Future<String> sellerLogin(String email, String password) async {
    final url = Uri.parse("$baseUrl/api/loginSeller");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      switch (response.statusCode) {
        case 200:
          final res = jsonDecode(response.body);
          await SellerSessionController()
              .saveSellerPrefs(res['sellerId'], res['token']);
          return "Login Sucessful";

        case 400:
          return "Seller with this email does not exis";

        case 401:
          return "Incorrect password";

        default:
          return "An unexpected error occurred. Please try again.";
      }
    } catch (error) {
      return "Failed to connect to the server. Error: $error";
    }
  }
}
