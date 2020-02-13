import 'package:flutter/material.dart';
import 'package:qr_code/debug/debug_data.dart';
import 'package:qr_code/models/medicine.dart';
import 'package:qr_code/models/search_parameter.dart';
import 'package:qr_code/repository/basic_api.dart';
import 'package:qr_code/util/api_parameter.dart';

class SearchResult extends StatefulWidget {
  SearchResult({@required this.arguments});

  final SearchParameter arguments;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  // TODO DBからデータ取得
  List<Medicine> localData = searchSampleData;
  SearchParameter args;

  @override
  void initState() {
    super.initState();
    print("SearchResult1, ");
//    aaa = ModalRoute.of(context).settings.arguments as SearchParameter;
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments as SearchParameter;
      });
    });
    BasicApi().postWordSearch(widget.arguments).then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
//        actions: [
//          Container(
//            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
//            margin: const EdgeInsets.all(8),
//            child: IconButton(
//              icon: Icon(Icons.refresh),
//              onPressed: () {
//                //TODO 更新確認処理
//                showBasicDialog(context, 'D0000');
//              },
//            ),
//          ),
//        ],
      ),
      body: Column(
        children: <Widget>[
          Align(
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Text('検索ワード：${widget.arguments.medicineWord}',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
          ),
          Expanded(
            child: _docList(),
          ),
        ],
      ),
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
//                leading: favIcon(index),
//              leading:Material(child: const Icon(Icons.favorite)),
//                trailing: editIcon(index),
                title: Text(localData[index].medicineName),
                subtitle: Text(item.docType),
                onTap: () {
                  Navigator.pushNamed(context, '/showpdf',
                      arguments: addBaseUrl(item.url));
                },
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
