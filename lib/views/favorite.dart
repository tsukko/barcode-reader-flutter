import 'package:flutter/material.dart';
import 'package:qr_code/util/const.dart';

import '../models/medicine.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  // 例
  List<Medicine> sampleData = new List<Medicine>.generate(
      10,
      (i) => new Medicine("(01)1498708010031$i", "アルプラゾラム $i",
          "/PmdaSearch/iyakuDetail/ResultDataSetPDF/780075_1124023F1118_1_04"));

  // Build a DocumentListScaffold to provide the UI for users to
  // create, edit, and delete documents
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("検索履歴"),
      ),
      body: ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (context, int index) {
          final item = sampleData[index];
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item.gs1code),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                sampleData.removeAt(index);
              });

              // Then show a snackbar.
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: ListTile(
              leading: const Icon(Icons.attach_file),
              title: Text(sampleData[index].medicineName),
              subtitle: Text(sampleData[index].gs1code),
              onTap: () {
                Navigator.pushNamed(context, '/showpdf',
                    arguments: Const.addBaseUrl(sampleData[index].url));
              },
            ),
          );
        },
      ),
    );
  }
}
