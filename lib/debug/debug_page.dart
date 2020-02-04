import 'package:flutter/material.dart';

class DebugDb extends StatefulWidget {
  @override
  _DebugDbState createState() => _DebugDbState();
}

class _DebugDbState extends State<DebugDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("debug_page"),
      ),
      body: RaisedButton(
        child: Text("ttt", style: TextStyle(fontSize: 18, color: Colors.white)),
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/search_conditional_detail');
        },
      ),
    );
  }
}
