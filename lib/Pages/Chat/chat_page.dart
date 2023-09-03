import 'package:chat/Pages/Chat/widgets/custom_card.dart';
import 'package:chat/constants/widgets/list_chat_model.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [...chatsModels];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: chats[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        onPressed: () {},
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}
