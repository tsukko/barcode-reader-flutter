import 'package:flutter/material.dart';
import 'package:qr_code/widget/common_divider.dart';
import 'package:qr_code/widget/common_divider2.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'メニュー',
              style: Theme.of(context).primaryTextTheme.title,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
//              color: Theme.of(context).indicatorColor,
            ),
            margin: EdgeInsets.zero,
          ),
          CommonDivider2(),
          Container(
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                ListTile(
                  selected: true,
                  leading: Icon(Icons.favorite, color: Colors.black),
                  title: Text('お知らせ', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/favorite');
                  },
                ),
                CommonDivider(),
                ListTile(
                  selected: true,
                  leading: Icon(Icons.favorite, color: Colors.black),
                  title: Text('お気に入り', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/favorite');
                  },
                ),
                CommonDivider2(),
                ListTile(
                  selected: true,
                  leading: Icon(Icons.settings, color: Colors.black),
                  title: Text('設定', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/favorite');
                  },
                ),
                CommonDivider(),
                ListTile(
                  selected: true,
                  leading: Icon(Icons.info_outline, color: Colors.black),
                  title:
                      Text('このアプリについて', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    showLicensePage(
                      context: context,
                      applicationName: "applicationName",
                      applicationVersion: "versionName",
                      applicationIcon: Image.asset(
                          "assets/medical_medicine.png",
                          scale: 3.0,
                          height: 100),
                      applicationLegalese: "applicationLegalese",
                      // useRootNavigator: true,
                    );
                  },
                ),
                CommonDivider2(),
                ListTile(
                  selected: true,
                  leading: Icon(Icons.settings, color: Colors.black),
                  title:
                      Text('debug_db', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/debug_db');
                  },
                ),
                CommonDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
