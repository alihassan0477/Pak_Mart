import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pakmart/Model/message_model.dart';
import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:pakmart/customWidgets/own_chat_card.dart';
import 'package:pakmart/customWidgets/reply_card.dart';
import 'package:pakmart/screens/Chats/repo/chat_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChatScreen extends StatefulWidget {
  const IndividualChatScreen({
    super.key,
    required this.receiverId,
    required this.sellerName,
  });

  final String receiverId;
  final String sellerName;

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController controller = TextEditingController();
  late IO.Socket socket;
  String? userId;
  List<Message> chatmessages = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> initData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");

    if (userId == null || widget.receiverId.isEmpty) {
      // handle invalid state here (e.g., navigate back or show error)
      return;
    }

    await fetchMessages();
    connectSocket();
  }

  Future<void> fetchMessages() async {
    try {
      final messages = await ChatRepo().fetchMessages(
        user1: userId!,
        user2: widget.receiverId,
      );

      setState(() {
        chatmessages = messages;
      });

      // Scroll to bottom after loading messages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
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
      if (userId != null) {
        socket.emit("join", userId);
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
              CircleAvatar(child: Text(widget.sellerName.substring(1, 4))),
            ],
          ),
        ),
        title: Text(
          widget.sellerName,
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

                  return message.senderId == userId
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
                        if (text.isNotEmpty && userId != null) {
                          sendMessage(text, userId!, widget.receiverId);
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
