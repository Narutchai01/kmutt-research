import 'dart:convert';

class StringModel {
  final String First_name;
  final String Last_name;
  final String SurveyorID;
  StringModel({
    required this.First_name,
    required this.Last_name,
    required this.SurveyorID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'First_name': First_name,
      'Last_name': Last_name,
      'SurveyorID': SurveyorID,
    };
  }

  factory StringModel.fromMap(Map<String, dynamic> map) {
    return StringModel(
      First_name: (map['First_name'] ?? '') as String,
      Last_name: (map['Last_name'] ?? '') as String,
      SurveyorID: (map['SurveyorID'] ?? '').toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StringModel.fromJson(String source) =>
      StringModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
