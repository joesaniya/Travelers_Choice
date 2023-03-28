// To parse this JSON data, do
//
//     final allAttractionOrders = allAttractionOrdersFromJson(jsonString);

import 'dart:convert';

AllAttractionOrders allAttractionOrdersFromJson(String? str) =>
    AllAttractionOrders.fromJson(json.decode(str!));

String? allAttractionOrdersToJson(AllAttractionOrders data) =>
    json.encode(data.toJson());

class AllAttractionOrders {
  AllAttractionOrders({
    this.result,
    this.skip,
    this.limit,
  });

  Result? result;
  int? skip;
  int? limit;

  factory AllAttractionOrders.fromJson(Map<String, dynamic> json) =>
      AllAttractionOrders(
        result: Result.fromJson(json["result"] ?? {}),
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "skip": skip,
        "limit": limit,
      };
}

class Result {
  Result({
    this.id,
    this.totalOrders,
    this.data,
  });

  dynamic? id;
  int? totalOrders;
  List<Datum>? data;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        totalOrders: json["totalOrders"],
        // data: json["data"] != null
        //     ? List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x)))
        //     : <Datum>[],
        data: List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalOrders": totalOrders,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.activities,
    this.totalAmount,
    this.orderStatus,
    this.name,
    this.email,
    this.phoneNumber,
    this.country,
    this.referenceNumber,
    this.createdAt,
    this.updatedAt,
    this.attraction,
  });

  String? id;
  Activities? activities;
  int? totalAmount;
  String? orderStatus;
  String? name;
  String? email;
  String? phoneNumber;
  Country? country;
  String? referenceNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  Attraction? attraction;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        activities: Activities.fromJson(json["activities"]),
        totalAmount: json["totalAmount"],
        orderStatus: json["orderStatus"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        country: Country.fromJson(json["country"]),
        referenceNumber: json["referenceNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        attraction: Attraction.fromJson(json["attraction"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "activities": activities!.toJson(),
        "totalAmount": totalAmount,
        "orderStatus": orderStatus,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "country": country!.toJson(),
        "referenceNumber": referenceNumber,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "attraction": attraction!.toJson(),
      };
}

class Activities {
  Activities({
    this.bookingType,
    this.activity,
    this.date,
    this.adultsCount,
    this.childrenCount,
    this.infantCount,
    this.transferType,
    this.adultTickets,
    this.childTickets,
    this.status,
    this.profit,
    this.offerAmount,
    this.isRefunded,
    this.id,
    this.destination,
  });

  String? bookingType;
  Activity? activity;
  DateTime? date;
  int? adultsCount;
  int? childrenCount;
  int? infantCount;
  String? transferType;
  List<dynamic>? adultTickets;
  List<dynamic>? childTickets;
  String? status;
  int? profit;
  int? offerAmount;
  bool? isRefunded;
  String? id;
  Activity? destination;

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
        bookingType: json["bookingType"],
        activity: Activity.fromJson(json["activity"]),
        date: DateTime.parse(json["date"]),
        adultsCount: json["adultsCount"],
        childrenCount: json["childrenCount"],
        infantCount: json["infantCount"],
        transferType: json["transferType"],
        adultTickets: List<dynamic>.from(json["adultTickets"].map((x) => x)),
        childTickets: List<dynamic>.from(json["childTickets"].map((x) => x)),
        status: json["status"],
        profit: json["profit"],
        offerAmount: json["offerAmount"],
        isRefunded: json["isRefunded"],
        id: json["_id"],
        destination: Activity.fromJson(json["destination"]),
      );

  Map<String, dynamic> toJson() => {
        "bookingType": bookingType,
        "activity": activity!.toJson(),
        "date": date!.toIso8601String(),
        "adultsCount": adultsCount,
        "childrenCount": childrenCount,
        "infantCount": infantCount,
        "transferType": transferType,
        "adultTickets": List<dynamic>.from(adultTickets!.map((x) => x)),
        "childTickets": List<dynamic>.from(childTickets!.map((x) => x)),
        "status": status,
        "profit": profit,
        "offerAmount": offerAmount,
        "isRefunded": isRefunded,
        "_id": id,
        "destination": destination!.toJson(),
      };
}

class Activity {
  Activity({
    this.name,
  });

  String? name;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Attraction {
  Attraction({
    this.title,
    this.images,
  });

  String? title;
  List<String>? images;

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        title: json["title"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "images": List<dynamic>.from(images!.map((x) => x)),
      };
}

class Country {
  Country({
    this.id,
    this.countryName,
    this.isocode,
    this.phonecode,
    this.flag,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? countryName;
  String? isocode;
  String? phonecode;
  String? flag;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["_id"],
        countryName: json["countryName"],
        isocode: json["isocode"],
        phonecode: json["phonecode"],
        flag: json["flag"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "countryName": countryName,
        "isocode": isocode,
        "phonecode": phonecode,
        "flag": flag,
        "isDeleted": isDeleted,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
