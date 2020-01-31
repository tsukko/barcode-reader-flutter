import 'package:flutter/material.dart';
import 'package:qr_code/models/debug_data.dart';
import 'package:qr_code/models/medicine.dart';

class SelectDocument extends StatefulWidget {
  @override
  _SelectDocumentState createState() => _SelectDocumentState();
}

class _SelectDocumentState extends State<SelectDocument> {
  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;
    final Medicine item = sampleData[index];

    return Scaffold(
      appBar: AppBar(
        title: Text("文書選択"),
      ),
      body: Column(
        children: <Widget>[
          Align(
            child: Card(
              margin: EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Text("医薬品名：${item.medicineName}",
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
          Expanded(
            child: list(),
          )
        ],
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      itemCount: docData.length,
      itemBuilder: (context, int index) {
        final item = docData[index];
        return ListTile(
          leading: const Icon(Icons.star),
          title: Text(item),
//          subtitle: Text(item),
          onTap: () {
//            Navigator.pushNamed(context, '/showpdf');
          },
        );
      },
    );
  }
}
