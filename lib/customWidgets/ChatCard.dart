import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;

  const ChatCard({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.done_all, size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  lastMessage,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
