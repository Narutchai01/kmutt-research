import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaseID_model {
  final String CaseID;
  CaseID_model({
    required this.CaseID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CaseID': CaseID,
    };
  }

  factory CaseID_model.fromMap(Map<String, dynamic> map) {
    return CaseID_model(
      CaseID: (map['CaseID'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaseID_model.fromJson(String source) =>
      CaseID_model.fromMap(json.decode(source) as Map<String, dynamic>);
}
