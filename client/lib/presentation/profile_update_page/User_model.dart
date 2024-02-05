import 'dart:convert';

class StringModel {
  final String First_name;
  final String Last_name;
  final String SurveyorID;
  final String Image;
  final String Birth_date;
  final String Phone_number;
  final String Email;
  final String Password;

  StringModel({
    required this.First_name,
    required this.Last_name,
    required this.SurveyorID,
    required this.Image,
    required this.Birth_date,
    required this.Phone_number,
    required this.Email,
    required this.Password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'First_name': First_name,
      'Last_name': Last_name,
      'SurveyorID': SurveyorID,
      'Image': Image,
      'Birth_date': Birth_date,
      'Phone_number': Phone_number,
      'Email': Email,
      'Password': Password,
    };
  }

  factory StringModel.fromMap(Map<String, dynamic> map) {
    return StringModel(
      First_name: (map['First_name'] ?? '') as String,
      Last_name: (map['Last_name'] ?? '') as String,
      SurveyorID: (map['SurveyorID'] ?? '').toString(),
      Image: (map['Image'] ?? '') as String,
      Birth_date: (map['Birth_date'] ?? '') as String,
      Phone_number: (map['Phone_number'] ?? '') as String,
      Email: (map['Email'] ?? '') as String,
      Password: (map['Password'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StringModel.fromJson(String source) =>
      StringModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
