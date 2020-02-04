import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/debug/debug_data.dart';

Widget _buildSignOutDialogAndroid(BuildContext context, List<String> data) {
  return AlertDialog(
      title: Text(data[0]),
      content: Text(data[1]),
      actions: <Widget>[
        FlatButton(
          child: Text(data[3]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(data[2]),
          onPressed: () {},
        )
      ]);
}

Widget _buildSignOutDialogiOS(BuildContext context, List<String> data) {
  return CupertinoAlertDialog(
      title: Text(data[0]),
      content: Text(data[1]),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(data[3]),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(data[2]),
          isDestructiveAction: true,
          onPressed: () {},
        )
      ]);
}

void showBasicDialog(BuildContext context, String dialogKey) {
  final List<String> data = dialogStr[dialogKey];

//  StatelessWidget dialog;
  StatelessWidget dialog = (Platform.isIOS
      ? _buildSignOutDialogiOS(context, data)
      : _buildSignOutDialogAndroid(context, data)) as StatelessWidget;

  showDialog(
      context: context,
      builder: (context) {
        return dialog;
      });
}
