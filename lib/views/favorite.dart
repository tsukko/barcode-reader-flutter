import 'package:flutter/material.dart';
import 'package:qr_code/debug/debug_data.dart';
import 'package:qr_code/models/medicine.dart';
import 'package:qr_code/util/const.dart';
import 'package:qr_code/widget/dialog.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
//  bool fav_flag = false;

  // TODO DBからデータ取得
  List<Medicine> localData = sampleData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り'),
        actions: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                //TODO 更新確認処理
                showBasicDialog(context, 'D0000');
              },
            ),
          ),
        ],
      ),
      body: _docList(),
    );
  }

  Widget _docList() {
    return ListView.builder(
      itemCount: localData.length,
      itemBuilder: (context, index) {
        final item = localData[index];
//          fav_flag = item.favorite;
        return Dismissible(
          key: Key(item.gs1code),
          onDismissed: (direction) {
            setState(() {
              localData.removeAt(index);
            });
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('$item dismissed')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red[200]),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: favIcon(index),
//              leading:Material(child: const Icon(Icons.favorite)),
                trailing: editIcon(index),
                title: Text(localData[index].medicineName),
                subtitle: Text(item.docType),
                onTap: () {
                  Navigator.pushNamed(context, '/showpdf',
                      arguments: Const.addBaseUrl(item.url));
                },
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget favIcon(int index) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            localData[index].favorite = !localData[index].favorite;
            //TODO DB更新
          });
        },
        child: Container(
          margin: const EdgeInsets.all(16),
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
          margin: const EdgeInsets.all(16),
          child: const Icon(Icons.mode_edit),
        ),
      ),
    );
  }
}
