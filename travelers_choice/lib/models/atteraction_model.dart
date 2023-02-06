// To parse this JSON data, do
//
//     final detailattractionModal = detailattractionModalFromJson(jsonString);

import 'dart:convert';

DetailattractionModal detailattractionModalFromJson(String str) =>
    DetailattractionModal.fromJson(json.decode(str));

String detailattractionModalToJson(DetailattractionModal data) =>
    json.encode(data.toJson());

class DetailattractionModal {
  DetailattractionModal({
    required this.id,
    required this.destination,
    required this.title,
    required this.category,
    required this.bookingType,
    this.startDate,
    this.endDate,
    required this.offDays,
    required this.durationType,
    required this.duration,
    required this.isActive,
    required this.latitude,
    required this.longitude,
    required this.isOffer,
    required this.offerAmountType,
    required this.offerAmount,
    required this.youtubeLink,
    required this.images,
    required this.highlights,
    required this.sections,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isDeleted,
    required this.availability,
    this.cancelBeforeTime,
    this.cancellationFee,
    required this.cancellationType,
    required this.faqs,
    required this.isApiConnected,
    required this.isCombo,
    required this.isCustomDate,
    required this.mapLink,
    required this.offDates,
    required this.reviews,
    required this.markup,
    required this.totalRating,
    required this.averageRating,
    required this.activities,
  });

  String id;
  Destination destination;
  String title;
  Category category;
  String bookingType;
  DateTime? startDate;
  DateTime? endDate;
  List<dynamic> offDays;
  String durationType;
  int duration;
  bool isActive;
  String latitude;
  String longitude;
  bool isOffer;
  String offerAmountType;
  int offerAmount;
  String youtubeLink;
  List<String> images;
  String highlights;
  List<Section> sections;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isDeleted;
  List<Availability> availability;
  dynamic cancelBeforeTime;
  dynamic cancellationFee;
  String cancellationType;
  List<dynamic> faqs;
  bool isApiConnected;
  bool isCombo;
  bool isCustomDate;
  String mapLink;
  List<dynamic> offDates;
  List<Review> reviews;
  Markup markup;
  int totalRating;
  double averageRating;
  List<Activity> activities;

  factory DetailattractionModal.fromJson(Map<String, dynamic> json) =>
      DetailattractionModal(
        id: json["_id"],
        destination: Destination.fromJson(json["destination"]),
        title: json["title"],
        category: Category.fromJson(json["category"]),
        bookingType: json["bookingType"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : null,
        endDate: json["endDate"] != null
            ? DateTime.parse(json["endDate"] ?? '')
            : null,
        offDays: List<dynamic>.from(json["offDays"].map((x) => x)),
        durationType: json["durationType"],
        duration: json["duration"],
        isActive: json["isActive"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isOffer: json["isOffer"],
        offerAmountType: json["offerAmountType"],
        offerAmount: json["offerAmount"],
        youtubeLink: json["youtubeLink"],
        images: List<String>.from(json["images"].map((x) => x)),
        highlights: json["highlights"],
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDeleted: json["isDeleted"],
        availability: List<Availability>.from(
            json["availability"].map((x) => Availability.fromJson(x))),
        cancelBeforeTime: json["cancelBeforeTime"],
        cancellationFee: json["cancellationFee"],
        cancellationType: json["cancellationType"],
        faqs: List<dynamic>.from(json["faqs"].map((x) => x)),
        isApiConnected: json["isApiConnected"],
        isCombo: json["isCombo"],
        isCustomDate: json["isCustomDate"],
        mapLink: json["mapLink"],
        offDates: List<dynamic>.from(json["offDates"].map((x) => x)),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        markup: Markup.fromJson(json["markup"]),
        totalRating: json["totalRating"],
        averageRating: json["averageRating"]?.toDouble(),
        activities: List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "destination": destination.toJson(),
        "title": title,
        "category": category.toJson(),
        "bookingType": bookingType,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "offDays": List<dynamic>.from(offDays.map((x) => x)),
        "durationType": durationType,
        "duration": duration,
        "isActive": isActive,
        "latitude": latitude,
        "longitude": longitude,
        "isOffer": isOffer,
        "offerAmountType": offerAmountType,
        "offerAmount": offerAmount,
        "youtubeLink": youtubeLink,
        "images": List<dynamic>.from(images.map((x) => x)),
        "highlights": highlights,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isDeleted": isDeleted,
        "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
        "cancelBeforeTime": cancelBeforeTime,
        "cancellationFee": cancellationFee,
        "cancellationType": cancellationType,
        "faqs": List<dynamic>.from(faqs.map((x) => x)),
        "isApiConnected": isApiConnected,
        "isCombo": isCombo,
        "isCustomDate": isCustomDate,
        "mapLink": mapLink,
        "offDates": List<dynamic>.from(offDates.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "markup": markup.toJson(),
        "totalRating": totalRating,
        "averageRating": averageRating,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
      };
}

class Activity {
  Activity({
    required this.id,
    required this.attraction,
    required this.name,
    required this.facilities,
    required this.adultAgeLimit,
    required this.adultPrice,
    required this.childAgeLimit,
    required this.childPrice,
    required this.infantAgeLimit,
    required this.infantPrice,
    required this.isVat,
    required this.vat,
    required this.base,
    required this.isTransferAvailable,
    required this.privateTransferPrice,
    required this.sharedTransferPrice,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isDeleted,
    this.adultCost,
    this.childCost,
    this.infantCost,
  });

  String id;
  String attraction;
  String name;
  String facilities;
  int adultAgeLimit;
  int adultPrice;
  int childAgeLimit;
  int childPrice;
  double infantAgeLimit;
  int infantPrice;
  bool isVat;
  int vat;
  String base;
  bool isTransferAvailable;
  int privateTransferPrice;
  int sharedTransferPrice;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isDeleted;
  dynamic adultCost;
  dynamic childCost;
  dynamic infantCost;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["_id"],
        attraction: json["attraction"],
        name: json["name"],
        facilities: json["facilities"],
        adultAgeLimit: json["adultAgeLimit"],
        adultPrice: json["adultPrice"],
        childAgeLimit: json["childAgeLimit"],
        childPrice: json["childPrice"],
        infantAgeLimit: json["infantAgeLimit"]?.toDouble(),
        infantPrice: json["infantPrice"],
        isVat: json["isVat"],
        vat: json["vat"],
        base: json["base"],
        isTransferAvailable: json["isTransferAvailable"],
        privateTransferPrice: json["privateTransferPrice"],
        sharedTransferPrice: json["sharedTransferPrice"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDeleted: json["isDeleted"],
        adultCost: json["adultCost"],
        childCost: json["childCost"],
        infantCost: json["infantCost"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "attraction": attraction,
        "name": name,
        "facilities": facilities,
        "adultAgeLimit": adultAgeLimit,
        "adultPrice": adultPrice,
        "childAgeLimit": childAgeLimit,
        "childPrice": childPrice,
        "infantAgeLimit": infantAgeLimit,
        "infantPrice": infantPrice,
        "isVat": isVat,
        "vat": vat,
        "base": base,
        "isTransferAvailable": isTransferAvailable,
        "privateTransferPrice": privateTransferPrice,
        "sharedTransferPrice": sharedTransferPrice,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isDeleted": isDeleted,
        "adultCost": adultCost,
        "childCost": childCost,
        "infantCost": infantCost,
      };
}

class Availability {
  Availability({
    required this.isEnabled,
    required this.day,
    required this.open,
    required this.close,
    required this.id,
  });

  bool isEnabled;
  String day;
  String open;
  String close;
  String id;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        isEnabled: json["isEnabled"],
        day: json["day"],
        open: json["open"],
        close: json["close"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "isEnabled": isEnabled,
        "day": day,
        "open": open,
        "close": close,
        "_id": id,
      };
}

class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.v,
    required this.icon,
  });

  String id;
  String categoryName;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  int v;
  String icon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        categoryName: json["categoryName"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        v: json["__v"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryName": categoryName,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "slug": slug,
        "__v": v,
        "icon": icon,
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

class Markup {
  Markup({
    required this.id,
    required this.attraction,
    required this.v,
    required this.createdAt,
    required this.markup,
    required this.markupType,
    required this.updatedAt,
  });

  String id;
  String attraction;
  int v;
  DateTime createdAt;
  int markup;
  String markupType;
  DateTime updatedAt;

  factory Markup.fromJson(Map<String, dynamic> json) => Markup(
        id: json["_id"],
        attraction: json["attraction"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        markup: json["markup"],
        markupType: json["markupType"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "attraction": attraction,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "markup": markup,
        "markupType": markupType,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Review {
  Review({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.attraction,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String title;
  String description;
  int rating;
  String attraction;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        rating: json["rating"],
        attraction: json["attraction"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "rating": rating,
        "attraction": attraction,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Section {
  Section({
    required this.title,
    required this.body,
    required this.id,
  });

  String title;
  String body;
  String id;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
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
