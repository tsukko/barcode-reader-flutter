import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/repository/basic_api.dart';
import 'package:qr_code/util/camera.dart';
import 'package:qr_code/widget/camera_view.dart';
import 'package:qr_code/widget/qr_scanner_overlay_shape.dart';

class BarcodeScan extends StatefulWidget {
  const BarcodeScan({
    Key key,
  }) : super(key: key);

  @override
  _BarcodeScanState createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  var qrText = "";
  var flashState = Camera.flash_on;
  var cameraState = Camera.front_camera;

//  QRViewController controller;
//  CameraController controller;

//  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  CameraController controller;
  static const platform = const MethodChannel('com.tasogarei.test/web');

  Future<void> getCameras() async {
    List<CameraDescription> cameras;
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);

    // バーコードデコードライブラリの初期化
//    await platform.invokeMethod('lib_init');
  }

  @override
  void initState() {
    super.initState();
    getCameras().then((_) {
      controller.initialize().then((_) {
        print("deb::controller.initialize");
        if (!mounted) {
          return;
        }

        controller.startImageStream((CameraImage availableImage) {
//          print("deb::controller.startImageStream");
          _scanText(availableImage);
        });
        setState(() {});
      });
    });
  }

  void _scanText(CameraImage availableImage) async {
//    print("deb::_scanText: start. "
//        "height:${availableImage.height}, width:${availableImage.width}.");
    String barcode = await platform.invokeMethod('web', {
      "bytes": availableImage.planes[0].bytes,
      "height": availableImage.height,
      "width": availableImage.width
    });

    if (!mounted) {
      return;
    }
    setState(() {
//      print("deb::_scanText: setState");
      if (barcode.isNotEmpty) {
        controller.stopImageStream();
        qrText = barcode;
//        Fluttertoast.showToast(msg: "barcode: $barcode");

//        final resUrl = await BasicApi().debugPost(barcode);
//        Navigator.pushNamed(context, '/showpdf', arguments: resUrl);
      }
    });
  }

  @override
  void dispose() {
    print("deb::dispose");
    if (controller != null && controller.value.isStreamingImages) {
      controller.stopImageStream();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(title: Text('Screen Barcode')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CameraView(
//              key: qrKey,
//              onQRViewCreated: _onQRViewCreated,
              cameraController: controller,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
            flex: 4,
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("This is the result of scan: $qrText"),
                  _row1(),
                  _row2(),
                ],
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
//              if (controller != null) {
//                controller.toggleFlash();
//                if (Camera.isFlashOn(flashState)) {
//                  setState(() {
//                    flashState = Camera.flash_off;
//                  });
//                } else {
//                  setState(() {
//                    flashState = Camera.flash_on;
//                  });
//                }
//              }
            },
            child: Text(flashState, style: TextStyle(fontSize: 20)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
//              if (controller != null) {
//                controller.flipCamera();
//                if (Camera.isBackCamera(cameraState)) {
//                  setState(() {
//                    cameraState = Camera.front_camera;
//                  });
//                } else {
//                  setState(() {
//                    cameraState = Camera.back_camera;
//                  });
//                }
//              }
            },
            child: Text(cameraState, style: TextStyle(fontSize: 20)),
          ),
        )
      ],
    );
  }

  Widget _row2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
//              controller?.pauseCamera();
            },
            child: Text('pause', style: TextStyle(fontSize: 20)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
//              controller?.resumeCamera();
            },
            child: Text('resume', style: TextStyle(fontSize: 20)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () async {
              final resUrl = await BasicApi().postSearch("");
//              final resUrl = await BasicApi().postMultiple("");
              print("QRView url: $resUrl");
              Navigator.pushNamed(context, '/showpdf', arguments: resUrl);
            },
            child: Text('test', style: TextStyle(fontSize: 20)),
          ),
        )
      ],
    );
  }
}
