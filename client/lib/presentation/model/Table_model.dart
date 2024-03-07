import 'dart:convert';

TableModel TableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String TableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    this.CaseID = '',
    this.Car_part = '',
    this.Damage_type = '',
    this.Damage_severity = '',
    this.DetailID = 0,
  });

  String CaseID;
  String Car_part;
  String Damage_type;
  String Damage_severity;
  int DetailID;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        CaseID: json["CaseID"] == null ? null : json["CaseID"],
        Car_part: json["Car_part"] == null ? null : json["Car_part"],
        Damage_type: json["Damage_type"] == null ? null : json["Damage_type"],
        Damage_severity:
            json["Damage_severity"] == null ? null : json["Damage_severity"],
        DetailID: json["DetailID"] == null ? null : json["DetailID"],
      );

  Map<String, dynamic> toJson() => {
        "CaseID": CaseID == null ? null : CaseID,
        "Car_part": Car_part == null ? null : Car_part,
        "Damage_type": Damage_type == null ? null : Damage_type,
        "Damage_severity": Damage_severity == null ? null : Damage_severity,
        "DetailID": DetailID == null ? null : DetailID,
      };
}
