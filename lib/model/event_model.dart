class EventModel {
  EventModel({
    this.id,
    this.eventName,
    this.eventPoint,
    this.eventDate,
    this.isEventActive,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String eventName;
  int eventPoint;
  DateTime eventDate;
  int isEventActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    eventName: json["event_name"],
    eventPoint: json["event_point"],
    eventDate: DateTime.parse(json["event_date"]),
    isEventActive: json["is_event_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}
