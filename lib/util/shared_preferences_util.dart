import 'dart:async';

import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  Future<String> lastDate() async {
    await initializeDateFormatting('ja_JP');
    final formatter = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getInt('last_data');
    String lastDate = '更新日時なし';
    if (data != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data);
      var formatted = formatter.format(dateTime);
      lastDate = formatted;
    }
    return lastDate;
  }

  Future<String> updateDate() async {
    await initializeDateFormatting('ja_JP');
    final formatter = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP');
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('last_data', timestamp);
    DateTime dateTimeNow = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedNow = formatter.format(dateTimeNow);
    String updateDate = formattedNow;

    return updateDate;
  }
}
