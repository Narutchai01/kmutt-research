import 'dart:convert';

class ProfileModel {
  final String first_profile;
  final String last_profile;
  final String Email;
  final int Phone;
  final String birthday;
  ProfileModel({
    required this.first_profile,
    required this.last_profile,
    required this.Email,
    required this.birthday,
    required this.Phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_profile': first_profile,
      'last_profile': last_profile,
      'Email': Email,
      'Phone': Phone,
      'birthday': birthday,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      first_profile: (map['first_profile'] ?? '') as String,
      last_profile: (map['last_profile'] ?? '') as String,
      Email: (map['Email'] ?? '') as String,
      Phone: (map['Phone'] ?? '') as int,
      birthday: (map['birthday'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
