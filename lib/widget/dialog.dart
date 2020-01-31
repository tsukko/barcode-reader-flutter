import 'package:flutter/material.dart';

enum _DialogActionType {
  cancel,
  ok,
}

void showBasicDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => new AlertDialog(
      title: new Text("タイトル"),
      content: new Text("本文"),
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
