import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, required this.chatContactModel});
  final ChatContactModel chatContactModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[200],
                radius: 23,
                child: SvgPicture.asset('assets/images/person.svg'),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.clear,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Text(
            chatContactModel.name,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
