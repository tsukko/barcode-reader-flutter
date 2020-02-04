import 'package:flutter/material.dart';

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
            ),
          ),
          ListTile(
            selected: true,
            leading: Icon(Icons.favorite),
            title: Text('お気に入り'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorite');
            },
          ),
          ListTile(
            selected: true,
            leading: Icon(Icons.settings),
            title: Text('設定'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorite');
            },
          ),
          ListTile(
            selected: true,
            leading: Icon(Icons.info_outline),
            title: Text('このアプリについて'),
            onTap: () {
              Navigator.pop(context);
              showLicensePage(
                context: context,
                applicationName: "applicationName",
                applicationVersion: "versionName",
                applicationIcon: new Image.asset("assets/medical_medicine.png",
                    scale: 3.0, height: 100),
                applicationLegalese: "applicationLegalese",
                // useRootNavigator: true,
              );
            },
          ),
          ListTile(
            selected: true,
            leading: Icon(Icons.settings),
            title: Text('debug_page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/debug_page');
            },
          ),
        ],
      ),
    );
  }
}
