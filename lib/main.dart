import 'package:flutter/material.dart';
import 'package:qr_code/CameraApp.dart';
import 'package:qr_code/views/barcode_scan.dart';
import 'package:qr_code/views/favorite.dart';
import 'package:qr_code/views/pdf.dart';
import 'package:qr_code/views/search_conditional.dart';
import 'package:qr_code/views/search_result.dart';
import 'package:qr_code/views/select_document.dart';
import 'package:qr_code/views/top.dart';
import 'package:qr_code/views/update_list.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
      routes: <String, WidgetBuilder>{
        '/top': (BuildContext context) => new Top(),
        '/qrview': (BuildContext context) => new BarcodeScan(),
        '/favorite': (BuildContext context) => new Favorite(),
        '/select_document': (BuildContext context) => new SelectDocument(),
        '/update_list': (BuildContext context) => new UpdateList(),
        '/search_conditional': (BuildContext context) =>
            new SearchConditional(),
        '/search_result': (BuildContext context) => new SearchResult(),
        '/showpdf': (BuildContext context) => new Pdf(),
        '/debug_camera': (BuildContext context) => new CameraApp(),
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
