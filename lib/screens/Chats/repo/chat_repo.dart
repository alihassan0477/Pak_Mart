import 'dart:convert';

import 'package:pakmart/Model/chat_model.dart';
import 'package:pakmart/Model/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepo {
  Future<List<Message>> fetchMessages({
    required String user1,
    required String user2,
  }) async {
    final url = Uri.parse(
      'http://${AppUrl.ANDROID_EMULATOR_IP}:2000/messages/$user1/$user2',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<ChatModel>> getChats() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("user_id");
    final url = Uri.parse(
      'http://${AppUrl.ANDROID_EMULATOR_IP}:${AppUrl.PORT}/chats/$userId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ChatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }
}
