import 'package:chat/Pages/Select%20Contact/buttom_card.dart';
import 'package:chat/Pages/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../model/chat_model.dart';

class LoginScreenRes extends StatefulWidget {
  const LoginScreenRes({super.key});

  @override
  State<LoginScreenRes> createState() => _LoginScreenResState();
}

class _LoginScreenResState extends State<LoginScreenRes> {
  ChatModel? sourceChat;
  List<ChatModel> chatsModels = [
    ChatModel(
      name: 'Osama Nabil',
      icon: 'iconassets/images/person.svg',
      isGroup: false,
      time: '4:00',
      currentMessage: 'Hello Flutter Dev...',
      id: 1,
    ),
    ChatModel(
      name: 'Ahmed Salah',
      icon: 'iconassets/images/person.svg',
      isGroup: false,
      time: '2:00',
      currentMessage: 'Hello Flutter Dev...',
      id: 2,
    ),
    ChatModel(
      name: 'Khalid Nabil',
      icon: 'iconassets/images/person.svg',
      isGroup: false,
      time: '4:00',
      currentMessage: 'Hello Flutter Dev...',
      id: 3,
    ),
    ChatModel(
      name: 'Lina Ahmed',
      icon: 'iconassets/images/person.svg',
      isGroup: false,
      time: '3:30',
      currentMessage: 'Hi there!',
      id: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatsModels.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              sourceChat = chatsModels.removeAt(index);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            chatmodels: chatsModels,
                            sourceChat: sourceChat,
                          )));
            },
            child: ButtomCard(
              name: chatsModels[index].name,
              iconData: Icons.person,
            ),
          );
        },
      ),
    );
  }
}
