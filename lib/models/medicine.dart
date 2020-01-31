// 検索した医薬品の情報
class Medicine {
  final String gs1code;
  final String medicineName;
  final String url;

  Medicine(this.gs1code, this.medicineName, this.url);

//  Medicine({this.gs1code, this.medicineName, this.attachmentUrl});
//
//  factory Medicine.fromJson(Map<String, dynamic> json) {
//    return Medicine(
//      gs1code: json['gs1code'],
//      medicineName: json['medicineName'],
//      attachmentUrl: json['attachmentUrl'],
//    );
//  }
}
