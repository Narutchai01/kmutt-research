import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerModel {
  final String CustomerID;
  final String Province;
  final String CarID;
  final String Policy_number;
  final String Image;
  final String Brand;
  final String Model;
  final String Color;
  final String Status;

  CustomerModel({
    required this.CustomerID,
    required this.Province,
    required this.CarID,
    required this.Policy_number,
    required this.Image,
    required this.Brand,
    required this.Model,
    required this.Color,
    required this.Status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CustomerID': CustomerID,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      CustomerID: (map['CustomerID'] ?? '') as String,
      Province: (map['Province'] ?? '') as String,
      CarID: (map['CarID'] ?? '') as String,
      Policy_number: (map['Policy_number'] ?? '') as String,
      Image: (map['Image'] ?? '') as String,
      Brand: (map['Brand'] ?? '') as String,
      Model: (map['Model'] ?? '') as String,
      Color: (map['Color'] ?? '') as String,
      Status: (map['Status'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
