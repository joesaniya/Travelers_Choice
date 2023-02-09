// To parse this JSON data, do
//
//     final allattractionModal = allattractionModalFromJson(jsonString);

import 'dart:convert';

import 'Country_modal.dart';

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
        attractions: Attractions.fromJson(json["attractions"] ?? {}),
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
        totalAttractions: json["totalAttractions"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            .toList(),
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
    this.offerAmount,
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
  int? offerAmount;
  List<String> images;
  int? cancelBeforeTime;
  int? cancellationFee;
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
        bookingType:
            bookingTypeValues.map[json["bookingType"]] ?? BookingType.BOOKING,
        durationType:
            durationTypeValues.map[json["durationType"]] ?? DurationType.DAYS,
        duration: json["duration"],
        isOffer: json["isOffer"],
        offerAmountType: offerAmountTypeValues.map[json["offerAmountType"]] ??
            OfferAmountType.FLAT,
        offerAmount: json["offerAmount"] ?? 0,
        images: List<String>.from(json["images"].map((x) => x)),
        cancelBeforeTime: json["cancelBeforeTime"] ?? 0,
        cancellationFee: json["cancellationFee"] ?? 0,
        cancellationType:
            cancellationTypeValues.map[json["cancellationType"]] ??
                CancellationType.FREE_CANCELLATION,
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
        "cancellationType":
            cancellationTypeValues.reverse[cancellationType] ?? cancellationFee,
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

enum CancellationType { NON_REFUNDABLE, FREE_CANCELLATION }

final cancellationTypeValues = EnumValues({
  "freeCancellation": CancellationType.FREE_CANCELLATION,
  "nonRefundable": CancellationType.NON_REFUNDABLE
});

class Category {
  Category({
    required this.categoryName,
    required this.slug,
  });

  CategoryName categoryName;
  Slug slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName:
            categoryNameValues.map[json["categoryName"]] ?? CategoryName.TOUR,
        slug: slugValues.map[json["slug"]] ?? Slug.ATTRACTIONS,
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryNameValues.reverse[categoryName],
        "slug": slugValues.reverse[slug],
      };
}

enum CategoryName { THEME_PARK, ATTRACTIONS, SKY_DIVING, MUSEUM, TOUR }

final categoryNameValues = EnumValues({
  "attractions": CategoryName.ATTRACTIONS,
  "museum": CategoryName.MUSEUM,
  "sky diving": CategoryName.SKY_DIVING,
  "theme park": CategoryName.THEME_PARK,
  "tour": CategoryName.TOUR
});

enum Slug { THEME_PARK, ATTRACTIONS, SKY_DIVING, MUSEUM, TOUR }

final slugValues = EnumValues({
  "attractions": Slug.ATTRACTIONS,
  "museum": Slug.MUSEUM,
  "sky-diving": Slug.SKY_DIVING,
  "theme-park": Slug.THEME_PARK,
  "tour": Slug.TOUR
});



enum Country {
  THE_63_AC33_ECFF04_E5652_A2583_F5,
  THE_63_C93_A583_B3_DE4_B73_B3_DA088
}

final countryValues = EnumValues({
  "63ac33ecff04e5652a2583f5": Country.THE_63_AC33_ECFF04_E5652_A2583_F5,
  "63c93a583b3de4b73b3da088": Country.THE_63_C93_A583_B3_DE4_B73_B3_DA088
});

enum Id {
  THE_63_AFBE8_FE2247_E66126_E41_CD,
  THE_63_AFBD4_CE2247_E66126_E419_D,
  THE_63_B0204_CB6_FC41_AAA6_F396_B9,
  THE_63_C93_B703_B3_DE4_B73_B3_DA0_CA
}

final idValues = EnumValues({
  "63afbd4ce2247e66126e419d": Id.THE_63_AFBD4_CE2247_E66126_E419_D,
  "63afbe8fe2247e66126e41cd": Id.THE_63_AFBE8_FE2247_E66126_E41_CD,
  "63b0204cb6fc41aaa6f396b9": Id.THE_63_B0204_CB6_FC41_AAA6_F396_B9,
  "63c93b703b3de4b73b3da0ca": Id.THE_63_C93_B703_B3_DE4_B73_B3_DA0_CA
});

enum ImageVal {
  PUBLIC_IMAGES_DESTINATIONS_IMAGE_167440861906061001879_WEBP,
  PUBLIC_IMAGES_DESTINATIONS_IMAGE_1672982741618547465184_JPG,
  PUBLIC_IMAGES_DESTINATIONS_IMAGE_1672982724148714879389_WEBP,
  PUBLIC_IMAGES_DESTINATIONS_IMAGE_1674132336190668432010_JPG
}

final imageValues = EnumValues({
  "/public/images/destinations/image-1672982724148-714879389.webp":
      ImageVal.PUBLIC_IMAGES_DESTINATIONS_IMAGE_1672982724148714879389_WEBP,
  "/public/images/destinations/image-1672982741618-547465184.jpg":
      ImageVal.PUBLIC_IMAGES_DESTINATIONS_IMAGE_1672982741618547465184_JPG,
  "/public/images/destinations/image-1674132336190-668432010.jpg":
      ImageVal.PUBLIC_IMAGES_DESTINATIONS_IMAGE_1674132336190668432010_JPG,
  "/public/images/destinations/image-1674408619060-61001879.webp":
      ImageVal.PUBLIC_IMAGES_DESTINATIONS_IMAGE_167440861906061001879_WEBP
});

enum Name { ABU_DHABI, DUBAI, SHARJAH, OMAN }

final nameValues = EnumValues({
  "abu dhabi": Name.ABU_DHABI,
  "dubai": Name.DUBAI,
  "oman": Name.OMAN,
  "sharjah": Name.SHARJAH
});

enum DurationType { HOURS, DAYS }

final durationTypeValues =
    EnumValues({"days": DurationType.DAYS, "hours": DurationType.HOURS});

enum OfferAmountType { FLAT, PERCENTAGE }

final offerAmountTypeValues = EnumValues(
    {"flat": OfferAmountType.FLAT, "percentage": OfferAmountType.PERCENTAGE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
