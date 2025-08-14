import 'dart:convert';

import 'package:pakmart/Model/SellerModel.dart';
import 'package:pakmart/Model/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:pakmart/Model/message_model.dart';
import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

class SellerChatRepo {
  Future<List<ChatModel>> fetchChats() async {
    final sellerId = SellerSessionController().seller_id;

    final url = Uri.parse(
      'http://${AppUrl.ANDROID_EMULATOR_IP}:${AppUrl.PORT}/chats/$sellerId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => ChatModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }

  Future<List<Message>> fetchMessages(String user1, String user2) async {
    final url = Uri.parse(
      'http://${AppUrl.ANDROID_EMULATOR_IP}:${AppUrl.PORT}/messages/$user1/$user2',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Message.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
