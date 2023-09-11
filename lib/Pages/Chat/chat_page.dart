import 'package:chat/Pages/Chat/widgets/custom_card.dart';
import 'package:chat/Pages/Select%20Contact/select_contact.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, this.chatmodel, this.sourceChatmodel})
      : super(key: key);
  final List<ChatModel>? chatmodel;
  final ChatModel? sourceChatmodel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<ChatModel> chats = [...chatsModels];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.chatmodel!.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: widget.chatmodel![index],
            sourceChat: widget.sourceChatmodel,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SelectContact()));
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}
