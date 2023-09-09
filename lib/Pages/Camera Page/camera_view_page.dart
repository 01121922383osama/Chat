import 'dart:io';

import 'package:chat/constants/widgets/media_query.dart';
import 'package:flutter/material.dart';

class CamerViewPage extends StatelessWidget {
  const CamerViewPage({super.key, required this.path});
  final String path;

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
                  maxLines: 6,
                  minLines: 1,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: 'Add Caption...',
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                    ),
                    suffixIcon: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 27,
                      child: Icon(Icons.check),
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
