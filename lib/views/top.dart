import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
import 'package:qr_code/models/shared_preferences.dart';
import 'package:qr_code/widget/debug_widget.dart';
import 'package:qr_code/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  String nowStr;
  String loadStr;

  void _readData() async {
    initializeDateFormatting('ja_JP');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      final formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP');
      final data = pref.getInt('last_data');
      if (data == null) {
        loadStr = '更新日時なし';
      } else {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data);
        var formatted = formatter.format(dateTime);
        loadStr = formatted;
      }

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      pref.setInt('last_data', timestamp);
      DateTime dateTimeNow = DateTime.fromMillisecondsSinceEpoch(timestamp);
      var formattedNow = formatter.format(dateTimeNow);
      nowStr = formattedNow;
    });
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    loadDate().then((v) => loadStr);
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(title: Text('Top Screen')),
      drawer: Menu().build(context),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: pendingWidget('top area.', 160.0),
//            child: Container(
//              margin: EdgeInsets.all(32.0),
//              child: FlutterLogo(
//                size: 120,
//              ),
//            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
//                debugCamera(context),
                _nowDate(),
                _lastDate(),
                _scan(),
                _search()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: pendingWidget('footer.', 88.0),
          ),
        ],
      ),
    );
  }

  Widget _nowDate() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Text("アクセス日時：$nowStr"),
    );
  }

  Widget _lastDate() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Text("最終更新日時：$loadStr"),
    );
  }

  Widget _scan() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/qrview');
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.photo_camera,
//                  color: Colors.pink,
                  size: 48.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child:
                    Text("バーコードを読み取り添付文書を検索する", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/select_document');
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.find_in_page,
//                  color: Colors.pink,
                  size: 48.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child:
                    Text("検索パラメータを設定して文書を検索する", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
