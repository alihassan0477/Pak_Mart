import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pakmart/constant/baseUrl.dart';
import 'package:pakmart/service/SharedPrefs.dart';

class User {
  static Future<bool> get_username_email() async {
    final userId = await SharedPrefs.getUserID();
    final url = Uri.parse("$baseUrl/api/get-user-data/$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);

        await SharedPrefs.setPrefsString("username", userJson['username']);
        await SharedPrefs.setPrefsString("email", userJson['email']);

        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
