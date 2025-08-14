import 'package:flutter/material.dart';
import 'package:pakmart/SellerCentral/repository/seller_chats/seller_chat_repo.dart';
import 'package:pakmart/SellerCentral/views/seller_chats/individual_seller_chat_screen.dart';
import 'package:pakmart/customWidgets/ChatCard.dart';
import 'package:pakmart/Model/chat_model.dart';

class SellerChatsScreen extends StatefulWidget {
  const SellerChatsScreen({super.key});

  @override
  State<SellerChatsScreen> createState() => _SellerChatsScreenState();
}

class _SellerChatsScreenState extends State<SellerChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      body: FutureBuilder<List<ChatModel>>(
        future: SellerChatRepo().fetchChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chats available.'));
          }

          final chats = snapshot.data!;

          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final chat = chats[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => IndividualSellerChatScreen(
                            receiverId: chat.receiverId,
                            customerName: chat.name,
                          ),
                    ),
                  );
                },
                child: ChatCard(
                  name: chat.name,
                  lastMessage: chat.latestMessage,
                  time: chat.timestamp,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
