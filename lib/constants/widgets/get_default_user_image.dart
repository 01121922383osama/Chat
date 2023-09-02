import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<Widget> getDefaultUserImage(String imageUrl) async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final pathReference = storageRef.child("defaultImage/$imageUrl");
    final imageData = await pathReference.getData();
    final imageWidget = Image.memory(
      imageData!,
      fit: BoxFit.cover,
    );
    return imageWidget;
  } catch (e) {
    print("Error loading user image: $e");
    return Container();
  }
}
