// To parse this JSON data, do
//
//     final availablePoint = availablePointFromJson(jsonString);

import 'dart:convert';

AvailablePoint availablePointFromJson(String str) => AvailablePoint.fromJson(json.decode(str));

class AvailablePoint {
  AvailablePoint({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory AvailablePoint.fromJson(Map<String, dynamic> json) => AvailablePoint(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.id,
    this.name,
    this.employeeCardId,
    this.point,
  });

  int id;
  dynamic name;
  int employeeCardId;
  int point;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    employeeCardId: json["employee_card_id"],
    point: json["point"],
  );

}
