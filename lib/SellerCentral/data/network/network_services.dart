import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pakmart/SellerCentral/data/exceptions/app_exceptions.dart';
import 'package:pakmart/SellerCentral/data/network/base_api_services.dart';

class NetworkServicesApi implements BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 50));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException("");
    } on TimeoutException {
      throw FetchDataException("Time out try again");
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    dynamic jsonResponse;

    // if (kDebugMode) {
    //   print(url);
    //   print(data);
    // }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException("");
    } on TimeoutException {
      throw FetchDataException("Time out try again");
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 50));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException("");
    } on TimeoutException {
      throw FetchDataException("Time out try again");
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> updateApi(String url, dynamic data) async {
    dynamic jsonResponse;

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException("");
    } on TimeoutException {
      throw FetchDataException("Time out try again");
    }

    return jsonResponse;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse;

    case 400:
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse;

    case 401:
      throw UnauthorizedException("");

    case 500:
      throw FetchDataException(
        "Error comunicating with server${response.statusCode}",
      );

    default:
  }
}
