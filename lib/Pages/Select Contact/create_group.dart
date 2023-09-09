import 'package:chat/Pages/Select%20Contact/contact_card.dart';
import 'package:chat/Pages/Select%20Contact/custom_avatar.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../../constants/widgets/list_chat_model.dart';

class CreateNewGroup extends StatefulWidget {
  const CreateNewGroup({super.key});

  @override
  State<CreateNewGroup> createState() => CreateContaNewGroup();
}

class CreateContaNewGroup extends State<CreateNewGroup> {
  List<ChatContactModel> chatContacts = [...chatContact];
  List<ChatContactModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text(
            'New group',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Add participants',
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: chatContacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.isNotEmpty ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  if (chatContacts[index - 1].isSelect == false) {
                    setState(() {
                      chatContacts[index - 1].isSelect = true;
                      groups.add(chatContacts[index - 1]);
                    });
                  } else {
                    setState(() {
                      chatContacts[index - 1].isSelect = false;
                      groups.remove(chatContacts[index - 1]);
                    });
                  }
                },
                child: ContactCard(
                  chatContactModel: chatContacts[index - 1],
                ),
              );
            },
          ),
          groups.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: CustomMediaQuery(context).screenHeight / 12,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: chatContacts.length,
                        itemBuilder: (context, index) {
                          if (chatContacts[index].isSelect == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  chatContacts[index].isSelect = false;
                                  groups.remove(chatContacts[index]);
                                });
                              },
                              child: CustomAvatar(
                                  chatContactModel: chatContacts[index]),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    // const Divider(thickness: 1),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
