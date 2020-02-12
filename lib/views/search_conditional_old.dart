import 'package:flutter/material.dart';
import 'package:qr_code/widget/dialog.dart';

class SearchConditional extends StatefulWidget {
  @override
  _SearchConditionalState createState() => _SearchConditionalState();
}

class _SearchConditionalState extends State<SearchConditional>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(
      text: 'GS1コード検索',
    ),
    const Tab(
      text: '医薬品名検索',
    ),
  ];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  }),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              margin: const EdgeInsets.all(8),
              child: IconButton(
                  icon: Icon(Icons.save_alt),
                  onPressed: () {
                    //TODO 検索条件の保存
                    showBasicDialog(context, 'D0002');
                  }),
            ),
          ],
          bottom: TabBar(
//          isScrollable: true,
            tabs: tabs,
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//            indicator: CustomTabIndicator(),
            labelColor: Colors.black,
          ),
        ),
        //Todo
        body: TabBarView(
          controller: _tabController,
          children: tabs.map(_createTab).toList(),
        ));
  }

  final List<Item> _data = generateItems(8);

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 2,
      children: _data.map<ExpansionPanelRadio>(
        (item) {
          return ExpansionPanelRadio(
            value: item.id,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(item.headerValue),
              );
            },
            body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(
                  () {
                    _data.removeWhere((currentItem) => item == currentItem);
                  },
                );
              },
            ),
          );
        },
      ).toList(),
    );
  }

  // TODO Radioで切り替え
  //  https://api.flutter.dev/flutter/material/Radio-class.html
  //  　https://qiita.com/matsukatsu/items/e289e30231fffb1e4502
  Widget _createTab(Tab tab) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }
//    return Center(
//      child: Text(
//        "10 min Rest Time",
//        style: TextStyle(fontSize: 24.0),
//      ),
//    );
//  }
}

class Item {
  Item({
    this.id,
    this.expandedValue,
    this.headerValue,
  });

  int id;
  String expandedValue;
  String headerValue;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (index) {
    return Item(
      id: index,
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
