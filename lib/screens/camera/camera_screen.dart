import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

//List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;

  @override
  void initState() {
    super.initState();

    /*_getCamera().then((value) => {

    controller = CameraController(value[0], ResolutionPreset.medium),

        controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }),*/

    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<List<CameraDescription>> _getCamera() async {
    cameras = await availableCameras();
    return cameras;
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller));
  }
}
