import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerModel {
  final String CustomerID;
  final String First_name;
  final String Last_name;
  final String Email;
  final int Phone_number;
  final String Image;
  final String Address;
  final String Line;
  CustomerModel({
    required this.CustomerID,
    required this.First_name,
    required this.Last_name,
    required this.Email,
    required this.Phone_number,
    required this.Image,
    required this.Address,
    required this.Line,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CustomerID': CustomerID,
      'First_name': First_name,
      'Last_name': Last_name,
      'Email': Email,
      'Phone_number': Phone_number,
      'Image': Image,
      'Address': Address,
      'Line': Line,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      CustomerID: (map['CustomerID'] ?? '') as String,
      First_name: (map['First_name'] ?? '') as String,
      Last_name: (map['Last_name'] ?? '') as String,
      Email: (map['Email'] ?? '') as String,
      Phone_number: (map['Phone_number'] ?? '') as int,
      Image: (map['Image'] ?? '') as String,
      Address: (map['Address'] ?? '') as String,
      Line: (map['Line'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
