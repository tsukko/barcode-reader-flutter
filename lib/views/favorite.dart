import 'package:flutter/material.dart';
import 'package:qr_code/models/debug_data.dart';
import 'package:qr_code/models/medicine.dart';
import 'package:qr_code/util/const.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var fav_flag = false;

  // TODO DBからデータ取得
  List<Medicine> localData = sampleData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("お気に入り"),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: localData.length,
        itemBuilder: (context, int index) {
          final item = localData[index];
//          fav_flag = item.favorite;
          return Dismissible(
            key: Key(item.gs1code),
            onDismissed: (direction) {
              setState(() {
                localData.removeAt(index);
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: ListTile(
              leading: favIcon(item.favorite, index),
//              leading:Material(child: const Icon(Icons.favorite)),
              trailing: editIcon(index),
              title: Text(localData[index].medicineName),
              subtitle: Text(item.gs1code),
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

  Widget favIcon(fav_f, index) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            localData[index].favorite = !localData[index].favorite;
            //TODO DB更新
          });
        },
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: localData[index].favorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
        ),
      ),
    );
  }

  Widget editIcon(int index) {
    return Material(
      child: InkWell(
        onTap: () {
          //TODO
          Navigator.pushNamed(context, '/select_document', arguments: index);
        },
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: const Icon(Icons.mode_edit),
        ),
      ),
    );
  }
}
