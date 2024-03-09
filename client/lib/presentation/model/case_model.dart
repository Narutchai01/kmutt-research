import 'dart:convert';

class CaseModel {
  final String CaseID;
  final int SurveyorID;
  final String CarID;
  final String Date_opened;
  final String Status;
  final String Description;
  final String Province;

  CaseModel({
    required this.CaseID,
    required this.SurveyorID,
    required this.CarID,
    required this.Date_opened,
    required this.Status,
    required this.Description,
    required this.Province,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CaseID': CaseID,
      'SurveyorID': SurveyorID,
      'CarID': CarID,
      'Date_opened': Date_opened,
      'Status': Status,
      'Description': Description,
      'Province': Province,
    };
  }

  factory CaseModel.fromMap(Map<String, dynamic> map) {
    return CaseModel(
      CaseID: map['CaseID'] as String,
      SurveyorID: map['SurveyorID'] as int,
      CarID: map['CarID'] as String,
      Date_opened: map['Date_opened'] as String,
      Status: map['Status'] as String,
      Description: map['Description'] as String,
      Province: map['Province'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory CaseModel.fromJson(String source) =>
      CaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
