import 'package:chat/Pages/Chat/indivisual_page.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;
  const CustomCard({Key? key, required this.chatModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IndivisualPage(chatModel: chatModel)));
          },
          child: ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: SvgPicture.asset(
                chatModel.isGroup
                    ? 'assets/images/groups.svg'
                    : 'assets/images/person.svg',
                color: Colors.white,
              ),
            ),
            trailing: Text(chatModel.time),
            title: Text(
              chatModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(width: 5),
                Text(chatModel.currentMessage),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
