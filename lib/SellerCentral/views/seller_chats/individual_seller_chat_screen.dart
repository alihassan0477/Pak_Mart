import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pakmart/Model/message_model.dart';
import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:pakmart/SellerCentral/repository/seller_chats/seller_chat_repo.dart';
import 'package:pakmart/customWidgets/own_chat_card.dart';
import 'package:pakmart/customWidgets/reply_card.dart';
import 'package:pakmart/screens/Chats/repo/chat_repo.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualSellerChatScreen extends StatefulWidget {
  const IndividualSellerChatScreen({
    super.key,
    required this.receiverId,
    required this.customerName,
  });

  final String receiverId;
  final String customerName;

  @override
  State<IndividualSellerChatScreen> createState() =>
      _IndividualSellerChatScreenState();
}

class _IndividualSellerChatScreenState
    extends State<IndividualSellerChatScreen> {
  final TextEditingController controller = TextEditingController();
  late IO.Socket socket;

  List<Message> chatmessages = [];
  final ScrollController scrollController = ScrollController();

  final sellerId = SellerSessionController().seller_id;

  @override
  void initState() {
    super.initState();
    fetchInitialMessages();
    connectSocket();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void connectSocket() {
    socket = IO.io(
      'http://${AppUrl.ANDROID_EMULATOR_IP}:${AppUrl.PORT}',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('Socket connected');
      if (sellerId.isNotEmpty) {
        socket.emit("join", sellerId);
      }
    });

    socket.on('receive_message', (data) {
      final message = Message.fromJson(data);

      print('Received message: $message');

      setState(() {
        chatmessages.add(message);
      });

      // Scroll to bottom on new message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void fetchInitialMessages() async {
    try {
      final messages = await SellerChatRepo().fetchMessages(
        sellerId,
        widget.receiverId,
      );

      setState(() {
        chatmessages = messages;
      });

      // Scroll to bottom after loading
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    } catch (e) {
      debugPrint('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leadingWidth: 70,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back),
              const SizedBox(width: 5),
              CircleAvatar(child: Text(widget.customerName.substring(1, 4))),
            ],
          ),
        ),
        title: Text(
          widget.customerName,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatmessages.length,
                itemBuilder: (context, index) {
                  final message = chatmessages[index];

                  return message.senderId == sellerId
                      ? OwnMessageCard(
                        message: message.content,
                        time: message.timestamp.toString(),
                      )
                      : ReplyCard(
                        message: message.content,
                        time: message.timestamp.toString(),
                      );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isNotEmpty && sellerId.isNotEmpty) {
                          sendMessage(text, sellerId, widget.receiverId);
                        }
                      },
                      icon: const Icon(Icons.send, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String content, String senderId, String receiverId) {
    socket.emit('send_message', {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
    });

    // Clear input immediately after sending
    controller.clear();
  }
}
