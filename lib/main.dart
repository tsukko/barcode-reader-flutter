import 'package:flutter/material.dart';
import 'package:qr_code/debug/camera_app.dart';
import 'package:qr_code/util/view_const.dart';
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
      theme: ThemeData(
//        brightness: Brightness.dark,
        primaryColor: Colors.grey[200],
        accentColor: Colors.black,
        indicatorColor: Colors.cyan[600],
        bottomAppBarColor: Colors.orange,
        backgroundColor: Colors.blue,
        // メニューのDrawerHeader以外の背景色
        canvasColor: Colors.orange[200],
        // 画面の背景色（未設定ならcanvasColorの色が使用される）
        scaffoldBackgroundColor: Colors.grey[100],
        //Colors.lime[50],
        toggleableActiveColor: Colors.pink[400],
        cardColor: Colors.white,
        hoverColor: Colors.blue[400],
        primaryTextTheme: TextTheme(
            headline: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ).merge(ViewConst.font_size_18)),
        accentTextTheme: TextTheme(
            headline: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ).merge(ViewConst.font_size_18)),
        textTheme: TextTheme(
          headline: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ).merge(ViewConst.font_size_18),
          body2: TextStyle(color: Colors.grey, height: 1.0)
              .merge(ViewConst.font_normal)
              .merge(ViewConst.font_size_15),
          body1: TextStyle(
            color: Colors.black54,
          ).merge(ViewConst.font_normal).merge(ViewConst.font_size_15),
          button: TextStyle(
            color: Colors.orange,
          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_18),
//          title: TextStyle(
//            color: Colors.teal,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_17),
//          subtitle: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          display4: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          display3: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          display2: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          display1: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          subhead: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          caption: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
//          overline: TextStyle(
//            color: Colors.amberAccent,
//          ).merge(ViewConst.font_medium).merge(ViewConst.font_size_16),
        ),
      ),
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
        image: Image.asset('assets/medical_medicine.png'),
        backgroundColor: ViewConst.splashBackgroundColor,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print('Flutter Egypt'),
        loaderColor: ViewConst.splashLoaderColor);
  }
}
