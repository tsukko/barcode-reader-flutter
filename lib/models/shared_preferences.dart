import 'dart:async';

import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
import 'package:shared_preferences/shared_preferences.dart';

Future<String> saveNowDate() async {
  initializeDateFormatting("ja_JP");
  final int timestamp = DateTime.now().millisecondsSinceEpoch;

  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('last_data', timestamp);

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final formatter = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP');
  final formatted = formatter.format(dateTime);
  return formatted;
}

Future<String> loadDate() async {
  initializeDateFormatting("ja_JP");
  final prefs = await SharedPreferences.getInstance();
  final int timestamp = prefs.getInt('last_data');

  if (timestamp == null) {
    return '更新日時なし';
  }
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final formatter = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP');
  final formatted = formatter.format(dateTime);
  return formatted;
}
