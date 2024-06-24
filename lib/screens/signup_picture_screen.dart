import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SignUpPictureScreen extends StatefulWidget {
  const SignUpPictureScreen({super.key});

  @override
  State<SignUpPictureScreen> createState() => _SignUpPictureScreenState();
}

class _SignUpPictureScreenState extends State<SignUpPictureScreen> {
  late CameraController _controller;

  Future<void>? _initializeControllerCamera() async {
    try {
      var cameras = await availableCameras();
      CameraDescription camera = cameras.first;
      _controller = CameraController(camera, ResolutionPreset.medium);
      return _controller.initialize();
    } catch (e) {
      return Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeControllerCamera(),
        builder: (context, snapshot) {
          var connState = snapshot.connectionState;
          if (connState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.camera),
        onPressed: () async {
          try {
            // _initializeControllerCamera();
            XFile file = await _controller.takePicture();
            Navigator.of(context).pop(file.path);
          } catch (e) {
            print(e);
          }
        },
        ),
    );
  }
}