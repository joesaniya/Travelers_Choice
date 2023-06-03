// To parse this JSON data, do
//
//     final attractionSearchDataModal = attractionSearchDataModalFromJson(jsonString);

import 'dart:convert';

AttractionSearchDataModal attractionSearchDataModalFromJson(String str) =>
    AttractionSearchDataModal.fromJson(json.decode(str));

String attractionSearchDataModalToJson(AttractionSearchDataModal data) =>
    json.encode(data.toJson());

class AttractionSearchDataModal {
  List<Attraction> attractions;
  int totoalAttraction;
  List<Destination> destinations;
  int totalDestination;

  AttractionSearchDataModal({
    required this.attractions,
    required this.totoalAttraction,
    required this.destinations,
    required this.totalDestination,
  });

  factory AttractionSearchDataModal.fromJson(Map<String, dynamic> json) =>
      AttractionSearchDataModal(
        attractions: List<Attraction>.from(
            json["attractions"].map((x) => Attraction.fromJson(x))),
        totoalAttraction: json["totoalAttraction"],
        destinations: List<Destination>.from(
            json["destinations"].map((x) => Destination.fromJson(x))),
        totalDestination: json["totalDestination"],
      );

  Map<String, dynamic> toJson() => {
        "attractions": List<dynamic>.from(attractions.map((x) => x.toJson())),
        "totoalAttraction": totoalAttraction,
        "destinations": List<dynamic>.from(destinations.map((x) => x.toJson())),
        "totalDestination": totalDestination,
      };
}

class Attraction {
  String id;
  Destination destination;
  String title;

  Attraction({
    required this.id,
    required this.destination,
    required this.title,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        id: json["_id"],
        destination: Destination.fromJson(json["destination"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "destination": destination.toJson(),
        "title": title,
      };
}

class Destination {
  Id id;
  Name name;

  Destination({
    required this.id,
    required this.name,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: idValues.map[json["_id"]]!,
        name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "name": nameValues.reverse[name],
      };
}

enum Id {
  THE_63_AFBE8_FE2247_E66126_E41_CD,
  THE_63_AFBD4_CE2247_E66126_E419_D,
  THE_63_B0204_CB6_FC41_AAA6_F396_B9,
  THE_63_C93_B703_B3_DE4_B73_B3_DA0_CA,
  THE_63_E35_FF04_A97_D9_B3_DF0_A92_D5,
  THE_63_EF68_A7_A51_F0_CBCFEEC87_B6,
  THE_63_EF695486842_C8_B96_CA8529,
  THE_64493_A646_AC157_F340064_A3_C
}

final idValues = EnumValues({
  "63afbd4ce2247e66126e419d": Id.THE_63_AFBD4_CE2247_E66126_E419_D,
  "63afbe8fe2247e66126e41cd": Id.THE_63_AFBE8_FE2247_E66126_E41_CD,
  "63b0204cb6fc41aaa6f396b9": Id.THE_63_B0204_CB6_FC41_AAA6_F396_B9,
  "63c93b703b3de4b73b3da0ca": Id.THE_63_C93_B703_B3_DE4_B73_B3_DA0_CA,
  "63e35ff04a97d9b3df0a92d5": Id.THE_63_E35_FF04_A97_D9_B3_DF0_A92_D5,
  "63ef68a7a51f0cbcfeec87b6": Id.THE_63_EF68_A7_A51_F0_CBCFEEC87_B6,
  "63ef695486842c8b96ca8529": Id.THE_63_EF695486842_C8_B96_CA8529,
  "64493a646ac157f340064a3c": Id.THE_64493_A646_AC157_F340064_A3_C
});

enum Name {
  ABU_DHABI,
  DUBAI,
  SHARJAH,
  OMAN,
  RAS_AL_KHAIMAH,
  HATTA,
  AJMAN,
  FUJAIRAH
}

final nameValues = EnumValues({
  "abu dhabi": Name.ABU_DHABI,
  "ajman": Name.AJMAN,
  "dubai": Name.DUBAI,
  "fujairah": Name.FUJAIRAH,
  "hatta": Name.HATTA,
  "oman": Name.OMAN,
  "ras al khaimah": Name.RAS_AL_KHAIMAH,
  "sharjah": Name.SHARJAH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
