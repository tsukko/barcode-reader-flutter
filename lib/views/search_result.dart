import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text('Result Screen')),
      backgroundColor: Colors.lime[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        mainAxisAlignment: MainAxisAlignment.center,
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
