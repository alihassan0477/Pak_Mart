import 'package:flutter/material.dart';
import 'package:pakmart/Model/chat_model.dart';
import 'package:pakmart/customWidgets/ChatCard.dart';

import 'package:pakmart/screens/Chats/IndividualChat.dart';
import 'package:pakmart/screens/Chats/repo/chat_repo.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Chats"),
      ),
      body: FutureBuilder<List<ChatModel>>(
        future: ChatRepo().getChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final chats = snapshot.data!;
          if (chats.isEmpty) {
            return const Center(child: Text("No chats available"));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return InkWell(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => IndividualChatScreen(
                              receiverId: chat.receiverId,
                              sellerName: chat.name,
                            ),
                      ),
                    ),
                child: ChatCard(
                  name: chat.name,
                  lastMessage: chat.latestMessage,
                  time: chat.timestamp.substring(11, 16),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
