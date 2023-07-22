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
  // EventName eventName;
  String eventName;
  DateTime startDateTime;
  DateTime endDateTime;
  String resourceId;
  String available;
  String status;
  dynamic adultPrice;
  dynamic childPrice;
  String? selectedSlots;
  bool isPrivate = false;
  bool isSharing = false;
  int adultCount = 1;
  int childCount = 0;
  int infantCount = 0;
  double totalAmount = 0;
  double grandTotal = 0;
  bool? isSelected = false;

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
    required this.selectedSlots,
    this.isPrivate = false,
    this.isSharing = false,
    this.adultCount = 1,
    this.childCount = 0,
    this.infantCount = 0,
    this.totalAmount = 0,
    this.grandTotal = 0,
    this.isSelected = false,
  });

  factory SlotTime.fromJson(Map<String, dynamic> json) => SlotTime(
        eventId: json["EventID"],
        eventName: json["EventName"],
        // eventName: eventNameValues.map[json["EventName"]]??,
        // startDateTime: DateTime.parse(json["StartDateTime"]),
         startDateTime: DateTime.parse(json["StartDateTime"]),
        endDateTime: DateTime.parse(json["EndDateTime"]),
        resourceId: json["ResourceID"],
        available: json["Available"],
        status: json["Status"],
        adultPrice: json["AdultPrice"],
        childPrice: json["ChildPrice"],
        selectedSlots: json['selectedSlots'],
        adultCount: 1,
        childCount: 0,
        infantCount: 0,
        grandTotal: 0,
      );

  Map<String, dynamic> toJson() => {
        "EventID": eventId,
        "EventName": eventName,
        // "EventName": eventNameValues.reverse[eventName],
        "StartDateTime": startDateTime.toIso8601String(),
        "EndDateTime": endDateTime.toIso8601String(),
        "ResourceID": resourceId,
        "Available": available,
        "Status": status,
        "AdultPrice": adultPrice,
        "ChildPrice": childPrice,
        "selectedSlots": selectedSlots
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



// import 'dart:convert';

// List<SlotTime> SlotTimeFromJson(String str) =>
//     List<SlotTime>.from(json.decode(str).map((x) => SlotTime.fromJson(x)));

// String SlotTimeToJson(List<SlotTime> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class SlotTime {
//   String eventId;
//   String eventName;
//   DateTime startDateTime;
//   DateTime endDateTime;
//   String resourceId;
//   String available;
//   String status;
//   dynamic adultPrice;
//   dynamic childPrice;
//   bool isSelected = false;

//   SlotTime({
//     required this.eventId,
//     required this.eventName,
//     required this.startDateTime,
//     required this.endDateTime,
//     required this.resourceId,
//     required this.available,
//     required this.status,
//     required this.adultPrice,
//     required this.childPrice,
//   });

//   factory SlotTime.fromJson(Map<String, dynamic> json) => SlotTime(
//         eventId: json["EventID"],
//         eventName: json["EventName"],
//         startDateTime: DateTime.parse(json["StartDateTime"]),
//         endDateTime: DateTime.parse(json["EndDateTime"]),
//         resourceId: json["ResourceID"],
//         available: json["Available"],
//         status: json["Status"],
//         adultPrice: json["AdultPrice"],
//         childPrice: json["ChildPrice"],
//       );

//   Map<String, dynamic> toJson() => {
//         "EventID": eventId,
//         "EventName": eventName,
//         "StartDateTime": startDateTime.toIso8601String(),
//         "EndDateTime": endDateTime.toIso8601String(),
//         "ResourceID": resourceId,
//         "Available": available,
//         "Status": status,
//         "AdultPrice": adultPrice,
//         "ChildPrice": childPrice,
//       };
// }
