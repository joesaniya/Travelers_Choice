// To parse this JSON data, do
//
//     final countryModal = countryModalFromJson(jsonString);

import 'dart:convert';

CountryModal countryModalFromJson(String str) =>
    CountryModal.fromJson(json.decode(str));

String countryModalToJson(CountryModal data) => json.encode(data.toJson());

class CountryModal {
  CountryModal({
    required this.countries,
    required this.destinations,
    required this.currencies,
  });

  List<CountryElement> countries;
  List<Destination> destinations;
  List<Currency> currencies;

  factory CountryModal.fromJson(Map<String, dynamic> json) => CountryModal(
        countries: List<CountryElement>.from(
            json["countries"].map((x) => CountryElement.fromJson(x))),
        destinations: List<Destination>.from(
            json["destinations"].map((x) => Destination.fromJson(x))),
        currencies: List<Currency>.from(
            json["currencies"].map((x) => Currency.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
        "destinations": List<dynamic>.from(destinations.map((x) => x.toJson())),
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
      };
}

class CountryElement {
  CountryElement({
    required this.id,
    required this.countryName,
    required this.isocode,
    required this.phonecode,
    required this.flag,
    this.currencySymbol,
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
  String? currencySymbol;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isDeleted;

  factory CountryElement.fromJson(Map<String, dynamic> json) => CountryElement(
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

class Currency {
  Currency({
    required this.id,
    required this.country,
    required this.currencyName,
    required this.currencySymbol,
    required this.isocode,
    required this.conversionRate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  CurrencyCountry country;
  String currencyName;
  String currencySymbol;
  String isocode;
  double conversionRate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["_id"],
        country: CurrencyCountry.fromJson(json["country"]),
        currencyName: json["currencyName"],
        currencySymbol: json["currencySymbol"],
        isocode: json["isocode"],
        conversionRate: json["conversionRate"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country": country.toJson(),
        "currencyName": currencyName,
        "currencySymbol": currencySymbol,
        "isocode": isocode,
        "conversionRate": conversionRate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class CurrencyCountry {
  CurrencyCountry({
    required this.id,
    required this.countryName,
    required this.flag,
  });

  String id;
  String countryName;
  String flag;

  factory CurrencyCountry.fromJson(Map<String, dynamic> json) =>
      CurrencyCountry(
        id: json["_id"],
        countryName: json["countryName"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "countryName": countryName,
        "flag": flag,
      };
}

class Destination {
  Destination({
    required this.id,
    required this.country,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isDeleted,
    required this.image,
  });

  String id;
  String country;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isDeleted;
  String image;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["_id"],
        country: json["country"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDeleted: json["isDeleted"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country": country,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isDeleted": isDeleted,
        "image": image,
      };
}
