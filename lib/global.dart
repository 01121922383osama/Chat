import 'package:camera/camera.dart';
import 'package:chat/Pages/Camera%20Page/custom_camera.dart';
import 'package:chat/constants/services/storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

class Global {
  static late AppStorageServices storageServices;
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await initializeService();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    try {
      camera = await availableCameras();
    } catch (e) {
      print('Error initializing the camera: $e');
      // Handle the error as needed (e.g., show an error message to the user)
      // You can set camera to null or take appropriate action.
      camera = [];
    }

    storageServices = await AppStorageServices().init();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
}
