import 'package:flutter/material.dart';
import 'package:qr_code/debug/camera_app.dart';
import 'package:qr_code/views/barcode_scan.dart';
import 'package:qr_code/views/favorite.dart';
import 'package:qr_code/views/pdf.dart';
import 'package:qr_code/views/search_conditional.dart';
import 'package:qr_code/views/search_conditional_detail.dart';
import 'package:qr_code/views/search_result.dart';
import 'package:qr_code/views/select_document.dart';
import 'package:qr_code/views/top.dart';
import 'package:qr_code/views/update_list.dart';
import 'package:splashscreen/splashscreen.dart';

import 'debug/debug_db.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
      routes: <String, WidgetBuilder>{
        '/top': (context) => Top(),
        '/qrview': (context) => const BarcodeScan(),
        '/favorite': (context) => Favorite(),
        '/select_document': (context) => SelectDocument(),
        '/update_list': (context) => UpdateList(),
        '/search_conditional': (context) => SearchConditional(),
        '/search_conditional_detail': (context) => SearchConditionalDetail(),
        '/search_result': (context) => SearchResult(),
        // 以降は、debug用。削除予定
        '/showpdf': (context) => Pdf(),
        '/debug_camera': (context) => CameraApp(),
        '/debug_db': (context) => DebugDb(),
//        '/license': (BuildContext context) => new LicenseScreen(),
      },
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: Top(),
        title: Text(
          'Welcome In SplashScreen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
//        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
//        image: new DecorationImage(
//          image: new AssetImage("assets/medical_medicine.png"),
//          fit: BoxFit.cover,
//        ),
        image: Image.asset('assets/medical_medicine.png'),
        backgroundColor: Colors.lightBlueAccent[100],
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print('Flutter Egypt'),
        loaderColor: Colors.red);
  }
}
