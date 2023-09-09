class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String? status;
  ChatModel({
    this.status,
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
  });
}

class ChatContactModel {
  String name;
  String status;
  bool isSelect = false;
  ChatContactModel({
    required this.name,
    required this.status,
    this.isSelect = false,
  });
}
