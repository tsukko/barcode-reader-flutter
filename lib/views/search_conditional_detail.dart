import 'package:flutter/material.dart';

class SearchConditionalDetail extends StatefulWidget {
  @override
  _SearchConditionalDetailState createState() =>
      _SearchConditionalDetailState();
}

class _SearchConditionalDetailState extends State<SearchConditionalDetail> {
  String _type = '';
  String _type1 = '';
  String _type2 = '';
  bool isCode = true;

  final TextEditingController _textEditingController =
      new TextEditingController();
  String _text = '';

  void _handleRadio(String e) => setState(() {
        _type = e;
        isCode = !isCode;
      });

  IconData _changeIcon(String e) {
    IconData icon = null;
    switch (e) {
      case 'thumb_up':
        icon = Icons.thumb_up;
        break;
      case 'favorite':
        icon = Icons.favorite;
        break;
      default:
        icon = Icons.thumb_up;
    }
    return icon;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_printLatestValue);

    setState(() {
      _type = "thumb_up";
      _type1 = "0";
      _type2 = "0";
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void _printLatestValue() {
    print("入力状況: ${_textEditingController.text}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(
        title: Text('条件検索'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new RadioListTile(
                  secondary: new Image.asset("assets/barcode.png", scale: 8.0),
                  activeColor: Colors.blue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('GS1 codeでの検索'),
                  value: 'thumb_up',
                  groupValue: _type,
                  onChanged: _handleRadio,
                ),
                isCode ? cardGs1Code() : Container(),
                new RadioListTile(
                  secondary:
                      new Image.asset("assets/medicine1.png", scale: 8.0),
                  activeColor: Colors.blue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('医薬品名での検索'),
                  value: 'favorite',
                  groupValue: _type,
                  onChanged: _handleRadio,
                ),
                isCode ? Container() : cardName(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // match_parent
              child: RaisedButton(
                child: Text("検索",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                color: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(10.0),
//              ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search_conditional');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardGs1Code() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Text("GS Code:", style: TextStyle(fontSize: 16)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: TextField(
                enabled: true,
                // 入力数
                maxLength: 14,
//                maxLengthEnforced: false,
//                obscureText: false,
                maxLines: 1,
                //パスワード
                onChanged: _handleText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardName() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text("医薬品名:", style: TextStyle(fontSize: 16)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: true,
//                    maxLengthEnforced: false,
//                    obscureText: false,
                    maxLines: 1,
                    onChanged: _handleText,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new Radio(
                activeColor: Colors.blue,
                value: '0',
                groupValue: _type1,
                onChanged: _handleRadio,
              ),
              Text("一般名及び販売名", style: TextStyle(fontSize: 12)),
              new Radio(
                activeColor: Colors.blue,
                value: '1',
                groupValue: _type1,
                onChanged: _handleRadio,
              ),
              Text("一般名のみ", style: TextStyle(fontSize: 12)),
              new Radio(
                activeColor: Colors.blue,
                value: '2',
                groupValue: _type1,
                onChanged: _handleRadio,
              ),
              Text("販売名のみ", style: TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            children: <Widget>[
              new Radio(
                activeColor: Colors.blue,
                value: '0',
                groupValue: _type2,
                onChanged: _handleRadio,
              ),
              Text("部分一致", style: TextStyle(fontSize: 12)),
              new Radio(
                activeColor: Colors.blue,
                value: '1',
                groupValue: _type2,
                onChanged: _handleRadio,
              ),
              Text("前方一致", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
