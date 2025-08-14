class ChatModel {
  final String receiverId;
  final String name;
  final String latestMessage;
  final String timestamp;

  ChatModel({
    required this.receiverId,
    required this.name,
    required this.latestMessage,
    required this.timestamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      receiverId: json['receiverId'],
      name: json['name'],
      latestMessage: json['latestMessage'],
      timestamp: json['timestamp'],
    );
  }
}
