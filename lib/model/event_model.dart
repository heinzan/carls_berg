class EventModel {
  EventModel({
    this.id,
    this.eventName,
    this.eventPoint,
    this.eventDate,
    this.isEventActive,
  });

  int id;
  String eventName;
  int eventPoint;
  String eventDate;
  int isEventActive;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    eventName: json["event_name"],
    eventPoint: json["event_point"],
    eventDate: json["event_date"],
    isEventActive: json["is_event_active"],
  );

}
