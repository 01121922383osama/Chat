import 'package:chat/Pages/Camera%20Page/custom_camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key, this.onImageSend});
  final Function()? onImageSend;
  @override
  Widget build(BuildContext context) {
    return  CustomCamera(onImageSend: onImageSend,);
  }
}
