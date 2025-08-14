import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pakmart/Model/RFQModel.dart';
import 'package:pakmart/constant/baseUrl.dart';
import 'package:pakmart/service/SharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RFQApi {
  static Future<int> create_RFQ({
    required String title,
    required String customTitle,
    required String productRequired,
    required String quantity,
    required String deliveryTime,
    required String Location,
  }) async {
    final url = Uri.parse('$baseUrl/api/create-RFQ');

    final customerId = await SharedPrefs.getUserID();

    final int? convertquantity = int.tryParse(quantity);

    final rfq = RFQ(
      title: title,
      Location: Location,
      customTitle: customTitle,
      customerId: customerId,
      productRequired: productRequired,
      deliveryTime: deliveryTime,
      quantity: convertquantity!,
    );

    try {
      final requestBody = rfq.toJson();

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      return response.statusCode;
    } catch (error) {
      return 0;
    }
  }
}
