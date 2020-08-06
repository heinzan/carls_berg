// To parse this JSON data, do
//
//     final eventResponse = eventResponseFromJson(jsonString);

import 'dart:convert';

import 'package:carlsberg/model/event_model.dart';

EventResponse eventResponseFromJson(String str) => EventResponse.fromJson(json.decode(str));

class EventResponse {
  EventResponse({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<EventModel> data;

  factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
    code: json["code"],
    message: json["message"],
    data: List<EventModel>.from(json["data"].map((x) => EventModel.fromJson(x))),
  );

}

