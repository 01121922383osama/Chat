import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chat/Pages/Camera%20Page/camera_view_page.dart';
import 'package:chat/Pages/Camera%20Page/video_view.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription>? camera;

class CustomCamera extends StatefulWidget {
  const CustomCamera({super.key});

  @override
  State<CustomCamera> createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  CameraController? cameraController;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool isFlash = false;
  bool isFlib = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }
      cameraController =
          CameraController(cameras[0], ResolutionPreset.ultraHigh);
      cameraValue = cameraController!.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (cameraController != null &&
                    cameraController!.value.isInitialized) {
                  return SizedBox(
                    width: CustomMediaQuery(context).screenWidth,
                    child: CameraPreview(cameraController!),
                  );
                } else {
                  return const Center(
                    child: Text('Camera not available'),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error initializing camera: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              width: CustomMediaQuery(context).screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFlash = !isFlash;
                          });
                          isFlash
                              ? cameraController!.setFlashMode(FlashMode.torch)
                              : cameraController!.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(
                          isFlash ? Icons.flash_on : Icons.flash_off,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onLongPress: () {
                          startVideoRecording(context);
                        },
                        onLongPressUp: () {
                          stopVideoRecording(context);
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      const SizedBox(width: 20),
                      Transform.rotate(
                        angle: transform,
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              isFlib = !isFlib;
                              transform = transform + pi;
                            });

                            try {
                              final cameras = await availableCameras();
                              if (cameras.isEmpty) {
                                throw Exception('No cameras available');
                              }

                              int cameraFlip = isFlib ? 0 : 1;
                              cameraController = CameraController(
                                cameras[cameraFlip],
                                ResolutionPreset.ultraHigh,
                              );

                              cameraValue = cameraController!.initialize();
                              setState(() {});
                            } catch (e) {
                              print('Error initializing camera: $e');
                            }
                          },
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text('Hold for a video, tap for a photo'),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startVideoRecording(BuildContext context) async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }

      // Initialize the camera controller here.
      cameraController =
          CameraController(cameras[isFlib ? 0 : 1], ResolutionPreset.ultraHigh);

      await cameraController?.initialize();
      await cameraController?.startVideoRecording();
      print(
          'Front Camera Initialized: ${cameraController!.value.isInitialized}');

      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  void stopVideoRecording(BuildContext context) async {
    if (!isRecording) {
      return;
    }

    try {
      final XFile? videoFile = await cameraController?.stopVideoRecording();
      if (videoFile == null) {
        throw Exception('Failed to record video');
      }

      final String videoPath = videoFile.path;

      final appDir = await getApplicationDocumentsDirectory();
      final String newVideoPath = '${appDir.path}/${DateTime.now()}.mp4';
      final File newVideoFile = await File(videoPath).copy(newVideoPath);

      setState(() {
        isRecording = false;
      });

      Future.delayed(
        Duration.zero,
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoViewPage(path: newVideoFile.path),
          ),
        ),
      );
    } catch (e) {
      print('Error recording video: $e');
    }
  }

  void takePhoto(BuildContext context) async {
    try {
      final XFile? imageFile = await cameraController?.takePicture();
      if (imageFile == null) {
        throw Exception('Failed to capture image');
      }

      final String imagePath = imageFile.path;

      final appDir = await getApplicationDocumentsDirectory();
      final String newImagePath = '${appDir.path}/${DateTime.now()}.png';
      final File newImageFile = await File(imagePath).copy(newImagePath);

      Future.delayed(
        Duration.zero,
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CamerViewPage(path: newImageFile.path),
          ),
        ),
      );
    } catch (e) {
      print('Error taking photo: $e');
    }
  }
}
