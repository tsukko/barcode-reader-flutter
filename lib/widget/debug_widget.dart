import 'package:flutter/material.dart';

// 開発デバッグ用のWidget置き場
Widget pendingWidget(String message, double pendingHeight) {
  return SizedBox(
    height: pendingHeight,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Placeholder(
//            color: Colors.red,
            ),
        Text(message, style: TextStyle(fontSize: 24)),
      ],
    ),
  );
}

Widget debugCamera(context) {
  return RaisedButton(
    child: Text("debug camera"),
    color: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(10.0),
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/debug_camera');
    },
  );
}
