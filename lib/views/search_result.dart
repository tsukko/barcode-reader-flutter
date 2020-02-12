import 'package:flutter/material.dart';
import 'package:qr_code/util/view_const.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Result Screen')),
      backgroundColor: ViewConst.baseBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8),
            child: RaisedButton(
              child: Text(args),
              onPressed: () {
//                test(args);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: RaisedButton(
              child: const Text('back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

//  void test(url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not Launch $url';
//    }
//  }
}
