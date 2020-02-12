import 'package:flutter/material.dart';
import 'package:qr_code/util/shared_preferences_util.dart';
import 'package:qr_code/widget/debug_widget.dart';
import 'package:qr_code/widget/menu.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  String nowStr;
  String loadStr;

  Future<void> _readData() async {
    loadStr = await SharedPreferencesUtil().lastDate();
    nowStr = await SharedPreferencesUtil().updateDate();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
      ),
      drawer: Menu().build(context),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: pendingWidget('top area.', 160.0),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[_nowDate(), _lastDate(), _scan(), _search()],
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
      child: Text('アクセス日時：$nowStr'),
    );
  }

  Widget _lastDate() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Text('最終更新日時：$loadStr'),
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
                margin: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.photo_camera,
                  size: 38.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child:
                    Text('バーコードを読み取り添付文書を検索する', style: TextStyle(fontSize: 18)),
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
        Navigator.pushNamed(context, '/search_conditional');
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.find_in_page,
//                  color: Colors.pink,
                  size: 38.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child:
                    Text('検索パラメータを設定して文書を検索する', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
