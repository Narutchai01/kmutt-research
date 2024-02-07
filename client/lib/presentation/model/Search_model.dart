import 'dart:convert';

SearchModel SearchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String SearchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.First_name = '',
    this.Last_name = '',
    this.image = '',
    this.CarID = '',
    this.Province = '',
  });

  String First_name;
  String Last_name;
  String image;
  String CarID;
  String Province;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        First_name: json["First_name"] == null ? null : json["First_name"],
        Last_name: json["Last_name"] == null ? null : json["Last_name"],
        image: json["image"] == null ? null : json["image"],
        CarID: json["CarID"] == null ? null : json["CarID"],
        Province: json["Province"] == null ? null : json["Province"],
      );

  Map<String, dynamic> toJson() => {
        "First_name": First_name == null ? null : First_name,
        "Last_name": Last_name == null ? null : Last_name,
        "image": image == null ? null : image,
        "CarID": CarID == null ? null : CarID,
        "Province": Province == null ? null : Province,
      };
}
