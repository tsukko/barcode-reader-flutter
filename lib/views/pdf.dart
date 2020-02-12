import 'package:flutter/material.dart';
import 'package:qr_code/util/api_parameter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pdf extends StatefulWidget {
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
//  bool _isLoading = true;

//  PDFDocument document;

  @override
  void initState() {
    print('PdfScreen initState');
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

  @override
  Widget build(BuildContext context) {
//    loadDocument();
//    final String url = "https://docs.google.com/gview?embedded=true&url=" +
//        ModalRoute.of(context).settings.arguments;
    final String url = ApiParameter.createLoadUrl(
        ModalRoute.of(context).settings.arguments as String);
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
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
      ),

//      Center(
//          child: _isLoading
//              ? Center(child: CircularProgressIndicator())
//              : PDFViewer(document: document)),
    );
  }
}
