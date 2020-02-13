import 'dart:async';

import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

// 削除予定
class Pdf {
  static Future<void> pdfToImage(String url) async {
    final PDFDocument doc = await PDFDocument.fromURL(url);
    return doc;
  }
}
