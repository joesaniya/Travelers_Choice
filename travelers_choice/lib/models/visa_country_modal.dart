// To parse this JSON data, do
//
//     final visaCountryModal = visaCountryModalFromJson(jsonString);

import 'dart:convert';

List<VisaCountryModal> visaCountryModalFromJson(String str) => List<VisaCountryModal>.from(json.decode(str).map((x) => VisaCountryModal.fromJson(x)));

String visaCountryModalToJson(List<VisaCountryModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VisaCountryModal {
  VisaCountryModal({
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
    this.termsAndConditions,
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
  String? termsAndConditions;

  factory VisaCountryModal.fromJson(Map<String, dynamic> json) => VisaCountryModal(
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
  });

  String id;
  String countryName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["_id"]?? "",
    countryName: json["countryName"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryName": countryName,
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
