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

import 'debug/debug_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
      routes: <String, WidgetBuilder>{
        '/top': (context) => Top(),
        '/qrview': (BuildContext context) => const BarcodeScan(),
        '/favorite': (BuildContext context) => Favorite(),
        '/select_document': (BuildContext context) => SelectDocument(),
        '/update_list': (BuildContext context) => UpdateList(),
        '/search_conditional': (BuildContext context) => SearchConditional(),
        '/search_conditional_detail': (BuildContext context) =>
            SearchConditionalDetail(),
        '/search_result': (BuildContext context) => SearchResult(),
        // 以降は、削除予定
        '/showpdf': (BuildContext context) => Pdf(),
        '/debug_camera': (BuildContext context) => CameraApp(),
        '/debug_page': (BuildContext context) => DebugDb(),
//        '/license': (BuildContext context) => new LicenseScreen(),
      },
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new Top(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
//        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
//        image: new DecorationImage(
//          image: new AssetImage("assets/medical_medicine.png"),
//          fit: BoxFit.cover,
//        ),
        image: new Image.asset("assets/medical_medicine.png"),
        backgroundColor: Colors.lightBlueAccent[100],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}
