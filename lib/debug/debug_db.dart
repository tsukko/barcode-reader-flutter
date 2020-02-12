import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/models/db/medicine_database_provider.dart';
import 'package:qr_code/models/medicine.dart';

class DebugDb extends StatefulWidget {
  @override
  _DebugDbState createState() => _DebugDbState();
}

class _DebugDbState extends State<DebugDb> {
  String qrText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("debug_db"),
      ),
      body: Column(
        children: <Widget>[
          Text('This is the result of scan: $qrText'),
          RaisedButton(
            child: Text("instert",
                style: TextStyle(fontSize: 18, color: Colors.white)),
            color: Colors.blue,
            onPressed: () async {
//              final resUrl = await BasicApi().postSearch("");
              final resUrl = await addMedicine();
//
//              setState(() {});
            },
          ),
          RaisedButton(
            child: Text("get",
                style: TextStyle(fontSize: 18, color: Colors.white)),
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, '/search_conditional_detail');
            },
          ),
          RaisedButton(
            child: Text("delete",
                style: TextStyle(fontSize: 18, color: Colors.white)),
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, '/search_conditional_detail');
            },
          ),
        ],
      ),
    );
  }

  Future<int> addMedicine() async {
    // debuggg
    await initializeDateFormatting('ja_JP');
    final formatter = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP');
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime dateTimeNow = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedNow = formatter.format(dateTimeNow);
    String updateDate = formattedNow;

    Medicine dummyData = Medicine(
        '(01)1498708010031',
        'テスト $updateDate',
        '添付文書',
        '/PmdaSearch/iyakuDetail/ResultDataSetPDF/780075_1124023F1118_1_04',
        true);
    final MedicineDatabaseProvider provider = MedicineDatabaseProvider();
    return 1; //await provider.insertMedicine(dummyData);
  }
}
