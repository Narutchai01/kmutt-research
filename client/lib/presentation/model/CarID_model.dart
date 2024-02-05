import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class carCustomerModel {
  final String CarID;
  final String Province;

  carCustomerModel({
    required this.Province,
    required this.CarID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CarID': CarID,
      'Province': Province,
    };
  }

  factory carCustomerModel.fromMap(Map<String, dynamic> map) {
    return carCustomerModel(
      CarID: (map['CarID'] ?? '') as String,
      Province: (map['Province'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory carCustomerModel.fromJson(String source) =>
      carCustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
