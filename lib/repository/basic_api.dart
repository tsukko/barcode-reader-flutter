import 'package:http/http.dart' as http;
import 'package:qr_code/models/medicine.dart';
import 'package:qr_code/models/search_medicine_result.dart';
import 'package:qr_code/models/search_parameter.dart';
import 'package:qr_code/util/api_parameter.dart';

class BasicApi {
  Future<String> postSearch(String codeId) async {
    final url = baseUrl + searchDir;
    final client = http.Client();

    if (codeId == '') {
//      codeId = '(01)14987080100314';
      print('error code is empty.');
      return null;
    }

    final bodyParam = getBodyGs1code(codeId);
    final hdr = getHeader();

    final response = await client.post(url, body: bodyParam, headers: hdr);

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
      for (final m in matches) {
        pdfUrl = baseUrl + m.group(0).replaceAll("'>", '');
      }

      return pdfUrl;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return '';
    }
  }

  Future<SearchMedicineResult> postWordSearch(SearchParameter param) async {
    final url = baseUrl + searchDir;
    final client = http.Client();
    Map<String, String> bodyParam;
    var code = param.gs1code;
    if (code.isNotEmpty) {
      bodyParam = getBodyGs1code(code);
    } else {
      bodyParam = getBodyMedicine(param);
    }
    final hdr = getHeader();

    final response = await client.post(url, body: bodyParam, headers: hdr);

    if (response.statusCode == 200) {
      final resBody = response.body.toString();
      // パース処理
      SearchMedicineResult aaa = parse(resBody);

      return aaa;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  SearchMedicineResult parse(String resBody) {
    final Iterable<Match> matches =
        RegExp('<td><div>.*?</div></td>').allMatches(resBody);
    List<Medicine> aaa;
    for (final m in matches) {
      print("SearchMedicineResult parse : $m");
      if (m.group(0).contains('/PmdaSearch/iyakuDetail/GeneralList')) {
        print("OKKKKK");
      }
    }
    return SearchMedicineResult(aaa.length, aaa);
  }
}
