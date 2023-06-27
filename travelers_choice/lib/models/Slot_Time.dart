// To parse this JSON data, do
//
//     final slotTime = slotTimeFromJson(jsonString);

import 'dart:convert';

List<SlotTime> slotTimeFromJson(String str) =>
    List<SlotTime>.from(json.decode(str).map((x) => SlotTime.fromJson(x)));

String slotTimeToJson(List<SlotTime> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlotTime {
  String eventId;
  EventName eventName;
  DateTime startDateTime;
  DateTime endDateTime;
  String resourceId;
  String available;
  String status;
  String adultPrice;
  String childPrice;

  SlotTime({
    required this.eventId,
    required this.eventName,
    required this.startDateTime,
    required this.endDateTime,
    required this.resourceId,
    required this.available,
    required this.status,
    required this.adultPrice,
    required this.childPrice,
  });

  factory SlotTime.fromJson(Map<String, dynamic> json) => SlotTime(
        eventId: json["EventID"],
        eventName: eventNameValues.map[json["EventName"]]!,
        startDateTime: DateTime.parse(json["StartDateTime"]),
        endDateTime: DateTime.parse(json["EndDateTime"]),
        resourceId: json["ResourceID"],
        available: json["Available"],
        status: json["Status"],
        adultPrice: json["AdultPrice"],
        childPrice: json["ChildPrice"],
      );

  Map<String, dynamic> toJson() => {
        "EventID": eventId,
        "EventName": eventNameValues.reverse[eventName],
        "StartDateTime": startDateTime.toIso8601String(),
        "EndDateTime": endDateTime.toIso8601String(),
        "ResourceID": resourceId,
        "Available": available,
        "Status": status,
        "AdultPrice": adultPrice,
        "ChildPrice": childPrice,
      };
}

enum EventName { BW }

final eventNameValues = EnumValues({"BW": EventName.BW});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
