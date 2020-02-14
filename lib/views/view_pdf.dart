import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:qr_code/util/api_parameter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pdf extends StatefulWidget {
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  bool _isLoading = true;
  String path;

//  PDFDocument document;

  @override
  void initState() {
    print('PdfScreen initState');
    loadPdf();
    super.initState();
  }

//  loadDocument() async {
//    print("PdfScreen loadDocument");
//    final String url = ModalRoute.of(context).settings.arguments;
//    print("PdfScreen url: $url");
//    var a = BasicApi.getPdf(url);
//    document =
//        await PDFDocument.fromFile(File.fromRawPath(a.buffer.asUint8List()));
//
//    document = await PDFDocument.fromURL(url);
//    setState(() => _isLoading = false);
//    print("load finish. $document");
//  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPost() async {
    final url =
        createLoadUrl(ModalRoute.of(context).settings.arguments as String);
    final response = await http.get(url);
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  Future<void> loadPdf() async {
    await writeCounter(await fetchPost());
    path = (await _localFile).path;

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
//    loadDocument();
    final url =
        createLoadUrl(ModalRoute.of(context).settings.arguments as String);
    WebViewController _controller;
    print('PdfScreen build :$url');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show PDF'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              print('PdfScreen refresh url: $url');
              _controller.loadUrl(url);
            },
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : PdfViewer(
                filePath: path,
              ),
      ),
//      WebView(
//        initialUrl: url,
//        javascriptMode: JavascriptMode.unrestricted,
//        onWebViewCreated: (controller) {
//          _controller = controller;
//        },
//      ),
    );
  }
}
