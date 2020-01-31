import 'dart:async';

import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
import 'package:shared_preferences/shared_preferences.dart';

Future<String> saveNowDate() async {
  initializeDateFormatting("ja_JP");
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('last_data', timestamp);

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
  var formatted = formatter.format(dateTime);
  return formatted;
}

Future<String> loadDate() async {
  initializeDateFormatting("ja_JP");
  final prefs = await SharedPreferences.getInstance();
  int timestamp = prefs.getInt('last_data');

  if (timestamp == null) {
    return "更新日時なし";
  }
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
  var formatted = formatter.format(dateTime);
  return formatted;
}
