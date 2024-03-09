import 'dart:convert';

class SearchModel {
  final String First_name;
  final String Last_name;
  final String image;
  final String CarID;
  final String Province;

  SearchModel({
    required this.First_name,
    required this.Last_name,
    required this.image,
    required this.CarID,
    required this.Province,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'First_name': First_name,
      'Last_name': Last_name,
      'image': image,
      'CarID': CarID,
      'Province': Province,
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      First_name: map['First_name'] as String,
      Last_name: map['Last_name'] as String,
      image: map['image'] as String,
      CarID: map['CarID'] as String,
      Province: map['Province'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) =>
      SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
