// To parse this JSON data, do
//
//     final createVisaApplication = createVisaApplicationFromJson(jsonString);

import 'dart:convert';

CreateVisaApplication createVisaApplicationFromJson(String str) => CreateVisaApplication.fromJson(json.decode(str));

String createVisaApplicationToJson(CreateVisaApplication data) => json.encode(data.toJson());

class CreateVisaApplication {

  CreateVisaApplication({
     this.visaType,
     this.visaPrice,
     this.clientMarkup,
     this.profit,
     this.totalAmount,
     this.email,
     this.contactNo,
     this.onwardDate,
     this.returnDate,
     this.noOfTravellers,
     this.travellers,
     this.user,
     this.status,
     this.referenceNumber,
     this.id,
     this.createdAt,
     this.updatedAt,
     this.v,
  });

  String? visaType;
  int? visaPrice;
  int? clientMarkup;
  int? profit;
  int? totalAmount;
  String? email;
  int? contactNo;
  DateTime? onwardDate;
  DateTime? returnDate;
  int? noOfTravellers;
  List<Traveller>? travellers;
  String? user;
  String? status;
  String? referenceNumber;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory CreateVisaApplication.fromJson(Map<String, dynamic> json) => CreateVisaApplication(
    visaType: json["visaType"],
    visaPrice: json["visaPrice"],
    clientMarkup: json["clientMarkup"],
    profit: json["profit"],
    totalAmount: json["totalAmount"],
    email: json["email"],
    contactNo: json["contactNo"],
    onwardDate: DateTime.parse(json["onwardDate"]),
    returnDate: DateTime.parse(json["returnDate"]),
    noOfTravellers: json["noOfTravellers"],
    travellers: List<Traveller>.from(json["travellers"].map((x) => Traveller.fromJson(x))),
    user: json["user"],
    status: json["status"],
    referenceNumber: json["referenceNumber"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "visaType": visaType,
    "visaPrice": visaPrice,
    "clientMarkup": clientMarkup,
    "profit": profit,
    "totalAmount": totalAmount,
    "email": email,
    "contactNo": contactNo,
    "onwardDate": onwardDate!.toIso8601String(),
    "returnDate": returnDate!.toIso8601String(),
    "noOfTravellers": noOfTravellers,
    "travellers": List<dynamic>.from(travellers!.map((x) => x.toJson())),
    "user": user,
    "status": status,
    "referenceNumber": referenceNumber,
    "_id": id,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Traveller {
  Traveller({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.expiryDate,
    required this.dateOfBirth,
    required this.country,
    required this.passportNo,
    required this.contactNo,
    required this.email,
    required this.isStatus,
    required this.id,
  });

  String title;
  String firstName;
  String lastName;
  DateOfBirth expiryDate;
  DateOfBirth dateOfBirth;
  String country;
  String passportNo;
  int contactNo;
  String email;
  String isStatus;
  String id;

  factory Traveller.fromJson(Map<String, dynamic> json) => Traveller(
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    expiryDate: DateOfBirth.fromJson(json["expiryDate"]),
    dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
    country: json["country"],
    passportNo: json["passportNo"],
    contactNo: json["contactNo"],
    email: json["email"],
    isStatus: json["isStatus"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "expiryDate": expiryDate.toJson(),
    "dateOfBirth": dateOfBirth.toJson(),
    "country": country,
    "passportNo": passportNo,
    "contactNo": contactNo,
    "email": email,
    "isStatus": isStatus,
    "_id": id,
  };
}

class DateOfBirth {
  DateOfBirth({
    required this.day,
    required this.month,
    required this.year,
  });

  int day;
  int month;
  int year;

  factory DateOfBirth.fromJson(Map<String, dynamic> json) => DateOfBirth(
    day: json["day"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "month": month,
    "year": year,
  };
}
