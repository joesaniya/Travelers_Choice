// To parse this JSON data, do
//
//     final selectVisaModal = selectVisaModalFromJson(jsonString);

import 'dart:convert';

SelectVisaModal selectVisaModalFromJson(String str) => SelectVisaModal.fromJson(json.decode(str));

String selectVisaModalToJson(SelectVisaModal data) => json.encode(data.toJson());

class SelectVisaModal {
  SelectVisaModal({
    required this.visa,
    required this.visaType,
  });

  Visa visa;
  List<VisaType> visaType;

  factory SelectVisaModal.fromJson(Map<String, dynamic> json) => SelectVisaModal(
    visa: Visa.fromJson(json["visa"]),
    visaType: List<VisaType>.from(json["visaType"].map((x) => VisaType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "visa": visa.toJson(),
    "visaType": List<dynamic>.from(visaType.map((x) => x.toJson())),
  };
}

class Visa {
  Visa({
    required this.id,
    required this.country,
    required this.name,
    required this.inclusions,
    required this.description,
    required this.sampleVisa,
    required this.faqs,
    required this.details,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.termsAndConditions,
  });

  String id;
  Country country;
  String name;
  List<String> inclusions;
  String description;
  String sampleVisa;
  List<Faq> faqs;
  List<Detail> details;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String termsAndConditions;

  factory Visa.fromJson(Map<String, dynamic> json) => Visa(
    id: json["_id"],
    country: Country.fromJson(json["country"]),
    name: json["name"],
    inclusions: List<String>.from(json["inclusions"].map((x) => x)),
    description: json["description"],
    sampleVisa: json["sampleVisa"],
    faqs: List<Faq>.from(json["faqs"].map((x) => Faq.fromJson(x))),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    termsAndConditions: json["termsAndConditions"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "country": country.toJson(),
    "name": name,
    "inclusions": List<dynamic>.from(inclusions.map((x) => x)),
    "description": description,
    "sampleVisa": sampleVisa,
    "faqs": List<dynamic>.from(faqs.map((x) => x.toJson())),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "termsAndConditions": termsAndConditions,
  };
}

class Country {
  Country({
    required this.id,
    required this.countryName,
    required this.isocode,
    required this.phonecode,
    required this.flag,
    required this.currencySymbol,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isDeleted,
  });

  String id;
  String countryName;
  String isocode;
  String phonecode;
  String flag;
  String currencySymbol;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isDeleted;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["_id"],
    countryName: json["countryName"],
    isocode: json["isocode"],
    phonecode: json["phonecode"],
    flag: json["flag"],
    currencySymbol: json["currencySymbol"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryName": countryName,
    "isocode": isocode,
    "phonecode": phonecode,
    "flag": flag,
    "currencySymbol": currencySymbol,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "isDeleted": isDeleted,
  };
}

class Detail {
  Detail({
    required this.title,
    required this.body,
    required this.id,
  });

  String title;
  String body;
  String id;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    title: json["title"],
    body: json["body"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "_id": id,
  };
}

class Faq {
  Faq({
    required this.question,
    required this.answer,
    required this.id,
  });

  String question;
  String answer;
  String id;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    question: json["question"],
    answer: json["answer"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "_id": id,
  };
}

class VisaType {
  VisaType({
    required this.id,
    required this.visa,
    required this.visaName,
    required this.processingTimeFormat,
    required this.processingTime,
    required this.stayPeriodFormat,
    required this.stayPeriod,
    required this.validityTimeFormat,
    required this.validity,
    required this.entryType,
    required this.tax,
    required this.insurance,
    required this.purchaseCost,
    required this.visaPrice,
    required this.ageFrom,
    required this.ageTo,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.markupClient,
    required this.totalPrice,
  });

  String id;
  String visa;
  String visaName;
  String processingTimeFormat;
  int processingTime;
  String stayPeriodFormat;
  int stayPeriod;
  String validityTimeFormat;
  int validity;
  String entryType;
  int tax;
  int insurance;
  int purchaseCost;
  int visaPrice;
  int ageFrom;
  int ageTo;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  MarkupClient? markupClient;
  int totalPrice;

  factory VisaType.fromJson(Map<String, dynamic> json) => VisaType(
    id: json["_id"],
    visa: json["visa"],
    visaName: json["visaName"],
    processingTimeFormat: json["processingTimeFormat"],
    processingTime: json["processingTime"],
    stayPeriodFormat: json["stayPeriodFormat"],
    stayPeriod: json["stayPeriod"],
    validityTimeFormat: json["validityTimeFormat"],
    validity: json["validity"],
    entryType: json["entryType"],
    tax: json["tax"],
    insurance: json["insurance"],
    purchaseCost: json["purchaseCost"],
    visaPrice: json["visaPrice"],
    ageFrom: json["ageFrom"],
    ageTo: json["ageTo"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    markupClient: json["markupClient"] == null ? null : MarkupClient.fromJson(json["markupClient"]),
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "visa": visa,
    "visaName": visaName,
    "processingTimeFormat": processingTimeFormat,
    "processingTime": processingTime,
    "stayPeriodFormat": stayPeriodFormat,
    "stayPeriod": stayPeriod,
    "validityTimeFormat": validityTimeFormat,
    "validity": validity,
    "entryType": entryType,
    "tax": tax,
    "insurance": insurance,
    "purchaseCost": purchaseCost,
    "visaPrice": visaPrice,
    "ageFrom": ageFrom,
    "ageTo": ageTo,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "markupClient": markupClient?.toJson(),
    "totalPrice": totalPrice,
  };
}

class MarkupClient {
  MarkupClient({
    required this.id,
    required this.visaType,
    required this.v,
    required this.createdAt,
    required this.markup,
    required this.markupType,
    required this.updatedAt,
  });

  String id;
  String visaType;
  int v;
  DateTime createdAt;
  int markup;
  String markupType;
  DateTime updatedAt;

  factory MarkupClient.fromJson(Map<String, dynamic> json) => MarkupClient(
    id: json["_id"],
    visaType: json["visaType"],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    markup: json["markup"],
    markupType: json["markupType"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "visaType": visaType,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "markup": markup,
    "markupType": markupType,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
