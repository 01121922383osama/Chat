import 'package:chat/Pages/Select%20Contact/buttom_card.dart';
import 'package:chat/Pages/Select%20Contact/contact_card.dart';
import 'package:chat/Pages/Select%20Contact/create_group.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../../constants/widgets/list_chat_model.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatContactModel> chatContacts = [...chatContact];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text(
            'Select Contact',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '250 Contact',
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
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'Invite a friend',
                  child: Text('Invite a friend'),
                ),
                const PopupMenuItem(
                  value: 'Contacts',
                  child: Text('Contacts'),
                ),
                const PopupMenuItem(
                  value: 'Refresh',
                  child: Text('Refresh'),
                ),
                const PopupMenuItem(
                  value: 'Help',
                  child: Text('Help'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: chatContacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CreateNewGroup()));
                },
                child: const ButtomCard(
                  name: 'New group',
                  iconData: Icons.group,
                ),
              );
            } else if (index == 1) {
              return const ButtomCard(
                name: 'New contact',
                iconData: Icons.person_add,
              );
            }
            return ContactCard(chatContactModel: chatContacts[index - 2]);
          }),
    );
  }
}
