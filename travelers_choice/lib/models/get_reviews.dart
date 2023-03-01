// To parse this JSON data, do
//
//     final getReview = getReviewFromJson(jsonString);

import 'dart:convert';

GetReview getReviewFromJson(String str) => GetReview.fromJson(json.decode(str));

String getReviewToJson(GetReview data) => json.encode(data.toJson());

class GetReview {
  GetReview({
    required this.attractionReviews,
    required this.totalAttractionReviews,
    required this.skip,
    required this.limit,
  });

  List<AttractionReview> attractionReviews;
  int totalAttractionReviews;
  int skip;
  int limit;

  factory GetReview.fromJson(Map<String, dynamic> json) => GetReview(
        attractionReviews: List<AttractionReview>.from(
            json["attractionReviews"].map((x) => AttractionReview.fromJson(x))),
        totalAttractionReviews: json["totalAttractionReviews"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "attractionReviews":
            List<dynamic>.from(attractionReviews.map((x) => x.toJson())),
        "totalAttractionReviews": totalAttractionReviews,
        "skip": skip,
        "limit": limit,
      };
}

class AttractionReview {
  AttractionReview({
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
  double rating;
  String attraction;
  User user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory AttractionReview.fromJson(Map<String, dynamic> json) =>
      AttractionReview(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        rating: json["rating"]?.toDouble(),
        attraction: json["attraction"],
        user: User.fromJson(json["user"]),
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
        "user": user.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
  });

  String id;
  String name;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
      };
}
