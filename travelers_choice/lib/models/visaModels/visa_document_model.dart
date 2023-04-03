// To parse this JSON data, do
//
//     final visaDocumentUpload = visaDocumentUploadFromJson(jsonString);

import 'dart:convert';

VisaDocumentUpload visaDocumentUploadFromJson(String str) => VisaDocumentUpload.fromJson(json.decode(str));

String visaDocumentUploadToJson(VisaDocumentUpload data) => json.encode(data.toJson());

class VisaDocumentUpload {
  VisaDocumentUpload({
    required this.visaApplication,
  });

  VisaApplication visaApplication;

  factory VisaDocumentUpload.fromJson(Map<String, dynamic> json) => VisaDocumentUpload(
    visaApplication: VisaApplication.fromJson(json["visaApplication"]),
  );

  Map<String, dynamic> toJson() => {
    "visaApplication": visaApplication.toJson(),
  };
}

class VisaApplication {
  VisaApplication({
    required this.id,
    required this.visaType,
    required this.visaPrice,
    required this.clientMarkup,
    required this.profit,
    required this.totalAmount,
    required this.email,
    required this.contactNo,
    required this.onwardDate,
    required this.returnDate,
    required this.noOfTravellers,
    required this.travellers,
    required this.user,
    required this.status,
    required this.referenceNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String visaType;
  int visaPrice;
  int clientMarkup;
  int profit;
  int totalAmount;
  String email;
  int contactNo;
  DateTime onwardDate;
  DateTime returnDate;
  int noOfTravellers;
  List<Traveller> travellers;
  String user;
  String status;
  String referenceNumber;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory VisaApplication.fromJson(Map<String, dynamic> json) => VisaApplication(
    id: json["_id"],
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
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "visaType": visaType,
    "visaPrice": visaPrice,
    "clientMarkup": clientMarkup,
    "profit": profit,
    "totalAmount": totalAmount,
    "email": email,
    "contactNo": contactNo,
    "onwardDate": onwardDate.toIso8601String(),
    "returnDate": returnDate.toIso8601String(),
    "noOfTravellers": noOfTravellers,
    "travellers": List<dynamic>.from(travellers.map((x) => x.toJson())),
    "user": user,
    "status": status,
    "referenceNumber": referenceNumber,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Traveller {
  Traveller({
    required this.expiryDate,
    required this.dateOfBirth,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.passportNo,
    required this.contactNo,
    required this.email,
    required this.isStatus,
    required this.id,
    required this.documents,
  });

  DateOfBirth expiryDate;
  DateOfBirth dateOfBirth;
  String title;
  String firstName;
  String lastName;
  String country;
  String passportNo;
  int contactNo;
  String email;
  String isStatus;
  String id;
  String documents;

  factory Traveller.fromJson(Map<String, dynamic> json) => Traveller(
    expiryDate: DateOfBirth.fromJson(json["expiryDate"]),
    dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    country: json["country"],
    passportNo: json["passportNo"],
    contactNo: json["contactNo"],
    email: json["email"],
    isStatus: json["isStatus"],
    id: json["_id"],
    documents: json["documents"],
  );

  Map<String, dynamic> toJson() => {
    "expiryDate": expiryDate.toJson(),
    "dateOfBirth": dateOfBirth.toJson(),
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "country": country,
    "passportNo": passportNo,
    "contactNo": contactNo,
    "email": email,
    "isStatus": isStatus,
    "_id": id,
    "documents": documents,
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
