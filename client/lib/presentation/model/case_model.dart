import 'dart:convert';

CaseModel CaseModelFromJson(String str) => CaseModel.fromJson(json.decode(str));

String CaseModelToJson(CaseModel data) => json.encode(data.toJson());

class CaseModel {
  CaseModel({
    this.CaseID = '',
    this.SurveyorID = 0,
    this.CarID = '',
    this.Date_opened = '',
    this.Status = '',
    this.Description = '',
    this.Province = '',
  });

  String CaseID;
  int SurveyorID;
  String CarID;
  String Date_opened;
  String Status;
  String Description;
  String Province;

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
        CaseID: json["CaseID"] == null ? null : json["CaseID"],
        SurveyorID: json["SurveyorID"] == null ? null : json["SurveyorID"],
        CarID: json["CarID"] == null ? null : json["CarID"],
        Date_opened: json["Date_opened"] == null ? null : json["Date_opened"],
        Status: json["Status"] == null ? null : json["Status"],
        Description: json["Description"] == null ? null : json["Description"],
        Province: json["Province"] == null ? null : json["Province"],
      );

  Map<String, dynamic> toJson() => {
        "CaseID": CaseID == null ? null : CaseID,
        "SurveyorID": SurveyorID == null ? null : SurveyorID,
        "CarID": CarID == null ? null : CarID,
        "Date_opened": Date_opened == null ? null : Date_opened,
        "Status": Status == null ? null : Status,
        "Description": Description == null ? null : Description,
        "Province": Province == null ? null : Province,
      };
}
