import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TokenModel {
  final String CaseID;
  TokenModel({
    required this.CaseID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CaseID': CaseID,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      CaseID: (map['CaseID'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
