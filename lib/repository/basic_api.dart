import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:qr_code/models/debug_data.dart';
import 'package:qr_code/util/const.dart';

class BasicApi {
  debugPost(String codeId) async {
    print("debugPost: codeId: $codeId");
    return postSearch(getRandomGs1Code());
  }

  postSearch(String codeId) async {
    var url = Const.baseUrl + Const.searchDir;
    DateTime timeStartReq = new DateTime.now();

    var client = http.Client();

    if (codeId == "") {
      codeId = '(01)14987080100314';
      return null;
    }
    print("deb1 codeId: $codeId");
    var bodyParam = Const.getBodyGs1code(codeId);
    var hdr = Const.getHeader();

    var response = await client.post(url, body: bodyParam, headers: hdr);

    DateTime timeSecondRes = new DateTime.now();

    if (response.statusCode == 200) {
      var resBody = response.body.toString();
//      Iterable<Match> matches =
//          new RegExp('<a target=\'_blank\' href=.*?</a>').allMatches(resBody);
//      <a target='_blank' href='/PmdaSearch/iyakuDetail/GeneralList/1124023'>アルプラゾラム</a>
//      <a target='_blank' href='/PmdaSearch/iyakuDetail/ResultDataSetPDF/780075_1124023F1118_1_04'>PDF(2019年07月22日)</a>
      Iterable<Match> matches =
          new RegExp('/PmdaSearch/iyakuDetail/ResultDataSetPDF/.*?>')
              .allMatches(resBody);

      var pdfUrl = Const.baseUrl;
      for (Match m in matches) {
        pdfUrl = Const.baseUrl + m.group(0).replaceAll("'>", "");
//        print("pdf url : $pdfUrl");
      }

      DateTime timeEndRes = new DateTime.now();
      int sinceEpochStartReq = timeStartReq.millisecondsSinceEpoch;
      int sinceEpochSecondRes = timeSecondRes.millisecondsSinceEpoch;
      int sinceEpochEndRes = timeEndRes.millisecondsSinceEpoch;
      var api_time = sinceEpochSecondRes - sinceEpochStartReq;
      var total_time = sinceEpochEndRes - sinceEpochStartReq;
      print("time log, api: $api_time (ms), total: $total_time (ms).");

      return pdfUrl;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "";
    }
  }

  // test用メソッド　ここから
  postMultiple(String codeId) async {
    var url = Const.baseUrl + Const.searchDir;

    var client = http.Client();

    if (codeId == "") {
      codeId = '(01)14987080100314';
    }
    var bodyParam = Const.getBodyGs1code(codeId);
    var hdr = Const.getHeader();
    DateTime timeStartReq = new DateTime.now();
    print("deb1 : $timeStartReq");
    List<http.Response> responses = await Future.wait([
      client.post(url, body: bodyParam, headers: hdr),
      client.post(url, body: bodyParam, headers: hdr),
      client.post(url, body: bodyParam, headers: hdr),
      client.post(url, body: bodyParam, headers: hdr),
      client.post(url, body: bodyParam, headers: hdr), //5
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //10
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //15
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //20
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //25
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //30
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //35
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //40
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //45
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr),
//      client.post(url, body: bodyParam, headers: hdr), //50
    ]);
    DateTime timeSecondRes = new DateTime.now();
    print("deb2: $timeSecondRes");

    var response = responses[0];

    if (response.statusCode == 200) {
      var resBody = response.body.toString();
      Iterable<Match> matches =
          new RegExp('/PmdaSearch/iyakuDetail/ResultDataSetPDF/.*?>')
              .allMatches(resBody);

      var pdfUrl = Const.baseUrl;
      for (Match m in matches) {
        pdfUrl = Const.baseUrl + m.group(0).replaceAll("'>", "");
//        print("pdf url : $pdfUrl");
      }
      DateTime timeEndRes = new DateTime.now();
      int sinceEpochStartReq = timeStartReq.millisecondsSinceEpoch;
      int sinceEpochSecondRes = timeSecondRes.millisecondsSinceEpoch;
      int sinceEpochEndRes = timeEndRes.millisecondsSinceEpoch;
      var api_time = sinceEpochSecondRes - sinceEpochStartReq;
      var total_time = sinceEpochEndRes - sinceEpochStartReq;

      print("time log, api: $api_time (ms), total: $total_time (ms).");
      return pdfUrl;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "";
    }
  }

  // 旧サイトに接続
  testHttpGet() async {
    var url =
        'https://www.info.pmda.go.jp/psearch/PackinsSearch?dragname=ソラナックス';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body.toString()}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static getPdf(String pdfUrl) async {
    var hdr = {
      "Accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept-Language": "ja,en-US;q=0.9,en;q=0.8",
      "Connection": "keep-alive",
      "Content-Type": "application/x-www-form-urlencoded",
      "Host": "www.pmda.go.jp",
    };
    var response = await http.get(pdfUrl, headers: hdr);
    if (response.statusCode == 200) {
//      print('Number of books about http: ${response.body.toString()}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return response.bodyBytes;
  }
// test用メソッド　ここまで
}
