import 'dart:convert';

class TableModel {
  final String CaseID;
  final String Car_part;
  final String Damage_type;
  final String Damage_severity;

  TableModel({
    required this.CaseID,
    required this.Car_part,
    required this.Damage_type,
    required this.Damage_severity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CaseID': CaseID,
      'Car_part': Car_part,
      'Damage_type': Damage_type,
      'Damage_severity': Damage_severity,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      CaseID: map['CaseID'] as String,
      Car_part: map['Car_part'] as String,
      Damage_type: map['Damage_type'] as String,
      Damage_severity: map['Damage_severity'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
