import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras;

//Future<void> main() async {
//  cameras = await availableCameras();
//  runApp(CameraApp());
//}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  var qrText = "";
  CameraController controller;

  Future<void> getCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
  }

  @override
  void initState() {
    super.initState();
    getCameras().then((_) {
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }

        /////////
        controller.startImageStream((CameraImage availableImage) {
//          controller.stopImageStream();
          _scanText(availableImage);
        });
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller.stopImageStream();
    super.dispose();
  }

  Future<String> takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/own_note';
    await Directory(dirPath).create(recursive: true);
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final String filePath = '$dirPath/${timestamp}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
//      await controller.takePicture(filePath);
      controller.startImageStream((CameraImage availableImage) {
//        controller.stopImageStream();
        _scanText(availableImage);
      });
    } on CameraException catch (e) {
      // エラー時の処理
      return null;
    }
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("result : $qrText", style: TextStyle(fontSize: 18)),
              RaisedButton(
                child: Icon(
                  Icons.camera,
                  size: 30,
                ),
                onPressed: () async {
                  var filePath = await takePicture();
                },
              ),
            ],
          ),
        ],
      );
    }
  }

  static const platform = const MethodChannel('com.tasogarei.test/web');

  void _scanText(CameraImage availableImage) async {
//    print("start _scanText. height:${availableImage.height}, "
//        "width:${availableImage.width}, format.group:${availableImage.format.group}.");
//
//    availableImage.planes.asMap()
//      ..forEach((index, plan) {
//        print("planes $index. height:${plan.height}, width:${plan.width},"
//            " bytesPerPixel:${plan.bytesPerPixel}, bytesPerRow:${plan.bytesPerRow},"
//            " length:${plan.bytes.length}, lengthInBytes:${plan.bytes.lengthInBytes},  ");
//      });

//    print("bytes    : ${availableImage.planes[0].bytes}");
//    print("bytes buf: ${availableImage.planes[0].bytes.buffer}");
    var bytesList = availableImage.planes.map((plane) {
      return plane.bytes;
    }).toList();
    String dateString = await platform.invokeMethod('web', {
      "bytes": availableImage.planes[0].bytes,
      "height": availableImage.height,
      "width": availableImage.width
    });
    setState(() {
      qrText = dateString;
      print("qrText: $qrText");
      if (dateString.isNotEmpty) {
        print("qrText: $qrText");
        controller.stopImageStream();
      }
    });
  }
}
