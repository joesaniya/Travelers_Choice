// To parse this JSON data, do
//
//     final searchCategoriesModal = searchCategoriesModalFromJson(jsonString);

import 'dart:convert';

List<SearchCategoriesModal> searchCategoriesModalFromJson(String str) =>
    List<SearchCategoriesModal>.from(
        json.decode(str).map((x) => SearchCategoriesModal.fromJson(x)));

String searchCategoriesModalToJson(List<SearchCategoriesModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCategoriesModal {
  SearchCategoriesModal({
    this.id,
    this.categoryName,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.v,
    this.icon,
  });

  String? id;
  String? categoryName;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  int? v;
  String? icon;

  factory SearchCategoriesModal.fromJson(Map<String, dynamic> json) =>
      SearchCategoriesModal(
        id: json["_id"],
        categoryName: json["categoryName"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        v: json["__v"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryName": categoryName,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "slug": slug,
        "__v": v,
        "icon": icon,
      };
}
