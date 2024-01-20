import 'dart:convert';
// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class SearchModel {
//   final String CaseID;
//   final int SurveyorID;
//   final String CarID;
//   final String Date_opened;
//   final String Status;
//   final String Description;
//   final String Province;
//   SearchModel({
//     required this.CaseID,
//     required this.SurveyorID,
//     required this.CarID,
//     required this.Date_opened,
//     required this.Status,
//     required this.Description,
//     required this.Province,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'CaseID': CaseID,
//       'SurveyorID': SurveyorID,
//       'CarID': CarID,
//       'Date_opened': Date_opened,
//       'Status': Status,
//       'Description': Description,
//       'Province': Province,
//     };
//   }

//   factory SearchModel.fromMap(Map<String, dynamic> map) {
//     return SearchModel(
//       CaseID: (map['CaseID'] ?? '') as String,
//       SurveyorID: (map['SurveyorID'] ?? '') as int,
//       CarID: (map['CarID'] ?? '') as String,
//       Date_opened: (map['Date_opened'] ?? '') as String,
//       Status: (map['Status'] ?? '') as String,
//       Description: (map['Description'] ?? '') as String,
//       Province: (map['Province'] ?? '') as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory SearchModel.fromJson(String source) =>
//       SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

SearchModel SearchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String SearchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.First_name = '',
    this.Last_name = '',
    this.image = '',
    this.CarID = '',
    this.Province = '',
  });

  String First_name;
  String Last_name;
  String image;
  String CarID;
  String Province;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        First_name: json["First_name"] == null ? null : json["First_name"],
        Last_name: json["Last_name"] == null ? null : json["Last_name"],
        image: json["image"] == null ? null : json["image"],
        CarID: json["CarID"] == null ? null : json["CarID"],
        Province: json["Province"] == null ? null : json["Province"],
      );

  Map<String, dynamic> toJson() => {
        "First_name": First_name == null ? null : First_name,
        "Last_name": Last_name == null ? null : Last_name,
        "image": image == null ? null : image,
        "CarID": CarID == null ? null : CarID,
        "Province": Province == null ? null : Province,
      };
}
