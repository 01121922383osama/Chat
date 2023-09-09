import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  final ChatContactModel chatContactModel;
  const ContactCard({super.key, required this.chatContactModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[200],
              radius: 23,
              child: SvgPicture.asset('assets/images/person.svg'),
            ),
            chatContactModel.isSelect
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(chatContactModel.name),
      subtitle: Text(chatContactModel.status),
    );
  }
}
