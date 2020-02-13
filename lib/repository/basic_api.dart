import 'package:http/http.dart' as http;
import 'package:qr_code/util/api_parameter.dart';

class BasicApi {
  Future<String> postSearch(String codeId) async {
    final url = baseUrl + searchDir;
//    DateTime timeStartReq = new DateTime.now();

    final client = http.Client();

    if (codeId == '') {
//      codeId = '(01)14987080100314';
      print('error code is empty.');
      return null;
    }
//    print('deb1 codeId: $codeId');
    final bodyParam = getBodyGs1code(codeId);
    final hdr = getHeader();

    final response = await client.post(url, body: bodyParam, headers: hdr);

//    DateTime timeSecondRes = new DateTime.now();

    if (response.statusCode == 200) {
      final resBody = response.body.toString();
      //TODO さまざまなパラメータをパースする
//      Iterable<Match> matches =
//          new RegExp('<a target=\'_blank\' href=.*?</a>').allMatches(resBody);
//      <a target='_blank' href='/PmdaSearch/iyakuDetail/GeneralList/1124023'>アルプラゾラム</a>
//      <a target='_blank' href='/PmdaSearch/iyakuDetail/ResultDataSetPDF/780075_1124023F1118_1_04'>PDF(2019年07月22日)</a>
      final Iterable<Match> matches =
          RegExp('/PmdaSearch/iyakuDetail/ResultDataSetPDF/.*?>')
              .allMatches(resBody);

      var pdfUrl = baseUrl;
      // ignore: prefer_final_in_for_each
      for (final m in matches) {
        pdfUrl = baseUrl + m.group(0).replaceAll("'>", '');
//        print('pdf url : $pdfUrl');
      }

//      DateTime timeEndRes = new DateTime.now();
//      int sinceEpochStartReq = timeStartReq.millisecondsSinceEpoch;
//      int sinceEpochSecondRes = timeSecondRes.millisecondsSinceEpoch;
//      int sinceEpochEndRes = timeEndRes.millisecondsSinceEpoch;
//      var api_time = sinceEpochSecondRes - sinceEpochStartReq;
//      var total_time = sinceEpochEndRes - sinceEpochStartReq;
//      print('time log, api: $api_time (ms), total: $total_time (ms).');

      return pdfUrl;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return '';
    }
  }
}
