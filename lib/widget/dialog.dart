import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum _DialogActionType {
  cancel,
  ok,
}

Widget _buildSignOutDialogAndroid(
    BuildContext context, String title, String content) {
  return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text("SignOut"),
          onPressed: () {},
        )
      ]);
}

Widget _buildSignOutDialogiOS(
    BuildContext context, String title, String message) {
  return CupertinoAlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to Sign out?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text('SignOut'),
          isDestructiveAction: true,
          onPressed: () {},
        )
      ]);
}

void showBasicDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => new AlertDialog(
      title: new Text(title),
      content: new Text(message),
      // ボタンの配置
      actions: <Widget>[
        new FlatButton(
            child: const Text('キャンセル'),
            onPressed: () {
              Navigator.pop(context, _DialogActionType.cancel);
            }),
        new FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context, _DialogActionType.ok);
            })
      ],
    ),
  ).then<void>((value) {
    // ボタンタップ時の処理
    switch (value) {
      case _DialogActionType.cancel:
        print("cancel...");
        break;
      case _DialogActionType.ok:
        print("OK!!");
        break;
      default:
        print("default");
    }
  });
}

Future showMyDialog(BuildContext context, Widget dialog) {
  return showDialog(
      context: context, builder: (BuildContext context) => dialog);
}

FlatButton cancelDialogButton(BuildContext context) {
  return new FlatButton(
      child: const Text('キャンセル'),
      onPressed: () {
        Navigator.pop(context);
      });
}
