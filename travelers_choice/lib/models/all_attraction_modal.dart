// To parse this JSON data, do
//
//     final allattractionModal = allattractionModalFromJson(jsonString);

import 'dart:convert';

AllattractionModal allattractionModalFromJson(String str) =>
    AllattractionModal.fromJson(json.decode(str));

String allattractionModalToJson(AllattractionModal data) =>
    json.encode(data.toJson());

class AllattractionModal {
  AllattractionModal({
    required this.attractions,
    required this.skip,
    required this.limit,
  });

  Attractions attractions;
  int skip;
  int limit;

  factory AllattractionModal.fromJson(Map<String, dynamic> json) =>
      AllattractionModal(
        attractions: Attractions.fromJson(json["attractions"]),
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "attractions": attractions.toJson(),
        "skip": skip,
        "limit": limit,
      };
}

class Attractions {
  Attractions({
    this.id,
    required this.totalAttractions,
    required this.data,
  });

  dynamic id;
  int totalAttractions;
  List<Datum> data;

  factory Attractions.fromJson(Map<String, dynamic> json) => Attractions(
        id: json["_id"],
        totalAttractions: json["totalAttractions"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalAttractions": totalAttractions,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.destination,
    required this.title,
    required this.category,
    required this.bookingType,
    required this.durationType,
    required this.duration,
    required this.isOffer,
    required this.offerAmountType,
    required this.offerAmount,
    required this.images,
    this.cancelBeforeTime,
    this.cancellationFee,
    required this.cancellationType,
    required this.isCombo,
    required this.activity,
    required this.totalReviews,
    required this.averageRating,
  });

  String id;
  Destination destination;
  String title;
  Category category;
  BookingType bookingType;
  DurationType durationType;
  int duration;
  bool isOffer;
  OfferAmountType offerAmountType;
  int offerAmount;
  List<String> images;
  dynamic cancelBeforeTime;
  dynamic cancellationFee;
  CancellationType cancellationType;
  bool isCombo;
  Activity activity;
  int totalReviews;
  double averageRating;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        destination: Destination.fromJson(json["destination"]),
        title: json["title"],
        category: Category.fromJson(json["category"]),
        bookingType: bookingTypeValues.map[json["bookingType"]]!,
        durationType: durationTypeValues.map[json["durationType"]]!,
        duration: json["duration"],
        isOffer: json["isOffer"],
        offerAmountType: offerAmountTypeValues.map[json["offerAmountType"]]!,
        offerAmount: json["offerAmount"],
        images: List<String>.from(json["images"].map((x) => x)),
        cancelBeforeTime: json["cancelBeforeTime"],
        cancellationFee: json["cancellationFee"],
        cancellationType: cancellationTypeValues.map[json["cancellationType"]]!,
        isCombo: json["isCombo"],
        activity: Activity.fromJson(json["activity"]),
        totalReviews: json["totalReviews"],
        averageRating: json["averageRating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "destination": destination.toJson(),
        "title": title,
        "category": category.toJson(),
        "bookingType": bookingTypeValues.reverse[bookingType],
        "durationType": durationTypeValues.reverse[durationType],
        "duration": duration,
        "isOffer": isOffer,
        "offerAmountType": offerAmountTypeValues.reverse[offerAmountType],
        "offerAmount": offerAmount,
        "images": List<dynamic>.from(images.map((x) => x)),
        "cancelBeforeTime": cancelBeforeTime,
        "cancellationFee": cancellationFee,
        "cancellationType": cancellationTypeValues.reverse[cancellationType],
        "isCombo": isCombo,
        "activity": activity.toJson(),
        "totalReviews": totalReviews,
        "averageRating": averageRating,
      };
}

class Activity {
  Activity({
    required this.adultPrice,
  });

  int adultPrice;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        adultPrice: json["adultPrice"],
      );

  Map<String, dynamic> toJson() => {
        "adultPrice": adultPrice,
      };
}

enum BookingType { TICKET, BOOKING }

final bookingTypeValues =
    EnumValues({"booking": BookingType.BOOKING, "ticket": BookingType.TICKET});

enum CancellationType { NON_REFUNDABLE }

final cancellationTypeValues =
    EnumValues({"nonRefundable": CancellationType.NON_REFUNDABLE});

class Category {
  Category({
    required this.categoryName,
    required this.slug,
  });

  CategoryName categoryName;
  Slug slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: categoryNameValues.map[json["categoryName"]]!,
        slug: slugValues.map[json["slug"]]!,
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryNameValues.reverse[categoryName],
        "slug": slugValues.reverse[slug],
      };
}

enum CategoryName { THEME_PARK, ATTRACTIONS, SKY_DIVING }

final categoryNameValues = EnumValues({
  "attractions": CategoryName.ATTRACTIONS,
  "sky diving": CategoryName.SKY_DIVING,
  "theme park": CategoryName.THEME_PARK
});

enum Slug { THEME_PARK, ATTRACTIONS, SKY_DIVING }

final slugValues = EnumValues({
  "attractions": Slug.ATTRACTIONS,
  "sky-diving": Slug.SKY_DIVING,
  "theme-park": Slug.THEME_PARK
});

class Destination {
  Destination({
    required this.id,
    required this.country,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isDeleted,
    // required this.image,
  });

  Id id;
  Country country;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isDeleted;
  // Image image;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: idValues.map[json["_id"]]!,
        country: countryValues.map[json["country"]]!,
        name: nameValues.map[json["name"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDeleted: json["isDeleted"],
        // image: imageValues.map[json["image"]]!,
      );

  Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "country": countryValues.reverse[country],
        "name": nameValues.reverse[name],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isDeleted": isDeleted,
        // "image": imageValues.reverse[image],
      };
}

enum Country { THE_63_AC33_ECFF04_E5652_A2583_F5 }

final countryValues = EnumValues(
    {"63ac33ecff04e5652a2583f5": Country.THE_63_AC33_ECFF04_E5652_A2583_F5});

enum Id { THE_63_AFBE8_FE2247_E66126_E41_CD, THE_63_AFBD4_CE2247_E66126_E419_D }

final idValues = EnumValues({
  "63afbd4ce2247e66126e419d": Id.THE_63_AFBD4_CE2247_E66126_E419_D,
  "63afbe8fe2247e66126e41cd": Id.THE_63_AFBE8_FE2247_E66126_E41_CD
});

// enum Image {
//   PUBLIC_IMAGES_DESTINATIONS_IMAGE_167440861906061001879_WEBP,
//   PUBLIC_IMAGES_DESTINATIONS_IMAGE_1672982741618547465184_JPG
// }

// final imageValues = EnumValues({
//   "/public/images/destinations/image-1672982741618-547465184.jpg":
//       Image.PUBLIC_IMAGES_DESTINATIONS_IMAGE_1672982741618547465184_JPG,
//   "/public/images/destinations/image-1674408619060-61001879.webp":
//       Image.PUBLIC_IMAGES_DESTINATIONS_IMAGE_167440861906061001879_WEBP
// });

enum Name { ABU_DHABI, DUBAI }

final nameValues =
    EnumValues({"abu dhabi": Name.ABU_DHABI, "dubai": Name.DUBAI});

enum DurationType { HOURS }

final durationTypeValues = EnumValues({"hours": DurationType.HOURS});

enum OfferAmountType { FLAT }

final offerAmountTypeValues = EnumValues({"flat": OfferAmountType.FLAT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
