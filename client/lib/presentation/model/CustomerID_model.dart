import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TokenModel {
  final String CarID;
  final String Province;

  TokenModel({
    required this.CarID,
    required this.Province,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CarID': CarID,
      'Province': Province,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      CarID: (map['CarID'] ?? '') as String,
      Province: (map['Province'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
