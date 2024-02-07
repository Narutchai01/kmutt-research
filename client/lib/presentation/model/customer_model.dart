import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerModel {
  final String First_name;
  final String Last_name;
  final String CarID;
  final String Customer_image;
  final String Car_Image;
  final String Address;
  final String Model;
  final String Brand;
  final String Policy_number;
  final String Policy_type;
  final String Start_date;
  final String End_date;
  final String Email;
  final String Phone_number;
  final String Line;

  CustomerModel({
    required this.First_name,
    required this.Last_name,
    required this.CarID,
    required this.Customer_image,
    required this.Car_Image,
    required this.Address,
    required this.Model,
    required this.Brand,
    required this.Policy_number,
    required this.Policy_type,
    required this.Start_date,
    required this.End_date,
    required this.Email,
    required this.Phone_number,
    required this.Line,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'First_name': First_name,
      'Last_name': Last_name,
      'CarID': CarID,
      'Customer_image': Customer_image,
      'Car_Image': Car_Image,
      'Address': Address,
      'Model': Model,
      'Brand': Brand,
      'Policy_number': Policy_number,
      'Policy_type': Policy_type,
      'Start_date': Start_date,
      'End_date': End_date,
      'Email': Email,
      'Phone_number': Phone_number,
      'Line': Line,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      First_name: map['First_name'] as String,
      Last_name: map['Last_name'] as String,
      CarID: map['CarID'] as String,
      Customer_image: map['Customer_image'] as String,
      Car_Image: map['Car_Image'] as String,
      Address: map['Address'] as String,
      Model: map['Model'] as String,
      Brand: map['Brand'] as String,
      Policy_number: map['Policy_number'] as String,
      Policy_type: map['Policy_type'] as String,
      Start_date: map['Start_date'] as String,
      End_date: map['End_date'] as String,
      Email: map['Email'] as String,
      Phone_number: map['Phone_number'] as String,
      Line: map['Line'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
