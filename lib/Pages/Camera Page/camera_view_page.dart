import 'dart:io';

import 'package:chat/constants/widgets/media_query.dart';
import 'package:flutter/material.dart';

class CamerViewPage extends StatelessWidget {
  const CamerViewPage({super.key, required this.path, this.onImageSend});
  final String path;
  final Function(String)? onImageSend;
  static TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.crop_rotate,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              size: 27,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: CustomMediaQuery(context).screenWidth,
        height: CustomMediaQuery(context).screenHeight,
        child: Stack(
          children: [
            SizedBox(
              width: CustomMediaQuery(context).screenWidth,
              height: CustomMediaQuery(context).screenHeight - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                width: CustomMediaQuery(context).screenWidth,
                child: TextFormField(
                  controller: textEditingController,
                  maxLines: 6,
                  minLines: 1,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    hintText: 'Add Caption...',
                    prefixIcon: const Icon(
                      Icons.add_photo_alternate,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (onImageSend != null) {
                          onImageSend!(path);
                          textEditingController.text.trim();
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 27,
                        child: Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
