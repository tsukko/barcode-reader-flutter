import 'package:flutter/material.dart';
import 'package:qr_code/debug/condition1.dart';
import 'package:qr_code/widget/dialog.dart';

class SearchConditional extends StatefulWidget {
  @override
  _SearchConditionalState createState() => _SearchConditionalState();
}

class _SearchConditionalState extends State<SearchConditional> {
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
    print('入力状況: ${_textEditingController.text}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(
        title: const Text('条件検索'),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () {
                //TODO 検索条件の削除
                showBasicDialog(context, 'D0001');
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: () {
                //TODO 検索条件の保存
                showBasicDialog(context, 'D0002');
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile(
                  secondary: Image.asset('assets/barcode.png', scale: 8),
                  activeColor: Colors.blue,
                  controlAffinity: ListTileControlAffinity.leading,
                  // ignore: prefer_const_constructors
                  title: const Text('GS1 codeでの検索'),
                  value: 'thumb_up',
                  groupValue: _type,
                  onChanged: _handleRadio,
                ),
                isCode ? cardGs1Code() : Container(),
                RadioListTile(
                  secondary: Image.asset('assets/medicine1.png', scale: 8),
                  activeColor: Colors.blue,
                  controlAffinity: ListTileControlAffinity.leading,
                  // ignore: prefer_const_constructors
                  title: const Text('医薬品名での検索'),
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
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity, // match_parent
              child: RaisedButton(
                child: const Text('検索',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                color: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(10.0),
//              ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search_conditional_detail');
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
      margin: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              child: const Text('GS Code:', style: TextStyle(fontSize: 16)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(8),
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
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: const Text('医薬品名:', style: TextStyle(fontSize: 16)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(8),
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
//          Row(
//            children: <Widget>[
//              Radio(
//                activeColor: Colors.blue,
//                value: '0',
//                groupValue: _type1,
//                onChanged: _handleRadio,
//              ),
//              const Text('一般名及び販売名', style: TextStyle(fontSize: 12)),
//              Radio(
//                activeColor: Colors.blue,
//                value: '1',
//                groupValue: _type1,
//                onChanged: _handleRadio,
//              ),
//              const Text('一般名のみ', style: TextStyle(fontSize: 12)),
//              Radio(
//                activeColor: Colors.blue,
//                value: '2',
//                groupValue: _type1,
//                onChanged: _handleRadio,
//              ),
//              const Text('販売名のみ', style: TextStyle(fontSize: 12)),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Radio(
//                activeColor: Colors.blue,
//                value: '0',
//                groupValue: _type2,
//                onChanged: _handleRadio,
//              ),
//              const Text('部分一致', style: TextStyle(fontSize: 12)),
//              Radio(
//                activeColor: Colors.blue,
//                value: '1',
//                groupValue: _type2,
//                onChanged: _handleRadio,
//              ),
//              const Text('前方一致', style: TextStyle(fontSize: 12)),
//            ],
//          ),
          DebugCondition(),
        ],
      ),
    );
  }
}
