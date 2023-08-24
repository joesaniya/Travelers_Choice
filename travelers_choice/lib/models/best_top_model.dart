// To parse this JSON data, do
//
//     final bestTopModel = bestTopModelFromJson(jsonString);

import 'dart:convert';

import 'all_attraction_modal.dart';
import 'atteraction_model.dart';

BestTopModel bestTopModelFromJson(String str) =>
    BestTopModel.fromJson(json.decode(str));

String bestTopModelToJson(BestTopModel data) => json.encode(data.toJson());

class BestTopModel {
  Home home;
  List<Datum> bestSellingAttractions;
  List<Attraction> topAttractions;
  List<RecentBlog> recentBlogs;

  BestTopModel({
    required this.home,
    required this.bestSellingAttractions,
    required this.topAttractions,
    required this.recentBlogs,
  });

  factory BestTopModel.fromJson(Map<String, dynamic> json) => BestTopModel(
        home: Home.fromJson(json["home"]),
          bestSellingAttractions: json["bestSellingAttractions"] != null
            ? List<Datum>.from(json["bestSellingAttractions"].map((x) => Datum.fromJson(x)))
                .toList()
            : <Datum>[],
        // bestSellingAttractions: List<Attraction>.from(
        //     json["bestSellingAttractions"].map((x) => Attraction.fromJson(x))),
        topAttractions: List<Attraction>.from(
            json["topAttractions"].map((x) => Attraction.fromJson(x))),
        recentBlogs: List<RecentBlog>.from(
            json["recentBlogs"].map((x) => RecentBlog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home": home.toJson(),
         "bestSellingAttractions": List<dynamic>.from(bestSellingAttractions.map((x) => x.toJson())),
        // "bestSellingAttractions":
        //     List<dynamic>.from(bestSellingAttractions.map((x) => x.toJson())),
        "topAttractions":
            List<dynamic>.from(topAttractions.map((x) => x.toJson())),
        "recentBlogs": List<dynamic>.from(recentBlogs.map((x) => x.toJson())),
      };
}

class Attraction {
  String id;
  Destination destination;
  String title;
  BestSellingAttractionCategory category;
  BookingType bookingType;
  List<String> images;
  String slug;
  Activity activity;
  int totalReviews;
  double? averageRating;
  double? averageReviews;

  Attraction({
    required this.id,
    required this.destination,
    required this.title,
    required this.category,
    required this.bookingType,
    required this.images,
    required this.slug,
    required this.activity,
    required this.totalReviews,
    this.averageRating,
    this.averageReviews,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        id: json["_id"],
        destination: Destination.fromJson(json["destination"]),
        title: json["title"],
        category: BestSellingAttractionCategory.fromJson(json["category"]),
        bookingType: bookingTypeValues.map[json["bookingType"]]!,
        images: List<String>.from(json["images"].map((x) => x)),
        slug: json["slug"],
        activity: Activity.fromJson(json["activity"]),
        totalReviews: json["totalReviews"],
        averageRating: json["averageRating"]?.toDouble(),
        averageReviews: json["averageReviews"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "destination": destination.toJson(),
        "title": title,
        "category": category.toJson(),
        "bookingType": bookingTypeValues.reverse[bookingType],
        "images": List<dynamic>.from(images.map((x) => x)),
        "slug": slug,
        "activity": activity.toJson(),
        "totalReviews": totalReviews,
        "averageRating": averageRating,
        "averageReviews": averageReviews,
      };
}

// class Activity {
//   int adultPrice;

//   Activity({
//     required this.adultPrice,
//   });

//   factory Activity.fromJson(Map<String, dynamic> json) => Activity(
//         adultPrice: json["adultPrice"],
//       );

//   Map<String, dynamic> toJson() => {
//         "adultPrice": adultPrice,
//       };
// }

enum BookingType { BOOKING, TICKET }

final bookingTypeValues =
    EnumValues({"booking": BookingType.BOOKING, "ticket": BookingType.TICKET});

class BestSellingAttractionCategory {
  String categoryName;
  String slug;

  BestSellingAttractionCategory({
    required this.categoryName,
    required this.slug,
  });

  factory BestSellingAttractionCategory.fromJson(Map<String, dynamic> json) =>
      BestSellingAttractionCategory(
        categoryName: json["categoryName"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "slug": slug,
      };
}

class Destination {
  Name name;

  Destination({
    required this.name,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
      };
}

enum Name { ABU_DHABI, DUBAI }

final nameValues =
    EnumValues({"abu dhabi": Name.ABU_DHABI, "dubai": Name.DUBAI});

class Home {
  String id;
  int settingsNumber;
  int v;
  List<String> bestSellingAttractions;
  List<Card> cards;
  DateTime createdAt;
  List<Footer> footer;
  List<String> heroImages;
  bool isBestSellingAttractionsSectionEnabled;
  bool isBlogsEnabled;
  bool isTopAttractionsSectionEnabled;
  String logo;
  List<String> topAttractions;
  DateTime updatedAt;
  String heroDescription;
  String heroTitle;
  String email;
  String facebookUrl;
  String footerDescription;
  String instagramUrl;
  String phoneNumber1;
  String phoneNumber2;
  List<HeroDta> heros;

  Home({
    required this.id,
    required this.settingsNumber,
    required this.v,
    required this.bestSellingAttractions,
    required this.cards,
    required this.createdAt,
    required this.footer,
    required this.heroImages,
    required this.isBestSellingAttractionsSectionEnabled,
    required this.isBlogsEnabled,
    required this.isTopAttractionsSectionEnabled,
    required this.logo,
    required this.topAttractions,
    required this.updatedAt,
    required this.heroDescription,
    required this.heroTitle,
    required this.email,
    required this.facebookUrl,
    required this.footerDescription,
    required this.instagramUrl,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.heros,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        id: json["_id"],
        settingsNumber: json["settingsNumber"],
        v: json["__v"],
        bestSellingAttractions:
            List<String>.from(json["bestSellingAttractions"].map((x) => x)),
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        footer:
            List<Footer>.from(json["footer"].map((x) => Footer.fromJson(x))),
        heroImages: List<String>.from(json["heroImages"].map((x) => x)),
        isBestSellingAttractionsSectionEnabled:
            json["isBestSellingAttractionsSectionEnabled"],
        isBlogsEnabled: json["isBlogsEnabled"],
        isTopAttractionsSectionEnabled: json["isTopAttractionsSectionEnabled"],
        logo: json["logo"],
        topAttractions: List<String>.from(json["topAttractions"].map((x) => x)),
        updatedAt: DateTime.parse(json["updatedAt"]),
        heroDescription: json["heroDescription"],
        heroTitle: json["heroTitle"],
        email: json["email"],
        facebookUrl: json["facebookUrl"],
        footerDescription: json["footerDescription"],
        instagramUrl: json["instagramUrl"],
        phoneNumber1: json["phoneNumber1"],
        phoneNumber2: json["phoneNumber2"],
        heros: List<HeroDta>.from(json["heros"].map((x) => HeroDta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "settingsNumber": settingsNumber,
        "__v": v,
        "bestSellingAttractions":
            List<dynamic>.from(bestSellingAttractions.map((x) => x)),
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "footer": List<dynamic>.from(footer.map((x) => x.toJson())),
        "heroImages": List<dynamic>.from(heroImages.map((x) => x)),
        "isBestSellingAttractionsSectionEnabled":
            isBestSellingAttractionsSectionEnabled,
        "isBlogsEnabled": isBlogsEnabled,
        "isTopAttractionsSectionEnabled": isTopAttractionsSectionEnabled,
        "logo": logo,
        "topAttractions": List<dynamic>.from(topAttractions.map((x) => x)),
        "updatedAt": updatedAt.toIso8601String(),
        "heroDescription": heroDescription,
        "heroTitle": heroTitle,
        "email": email,
        "facebookUrl": facebookUrl,
        "footerDescription": footerDescription,
        "instagramUrl": instagramUrl,
        "phoneNumber1": phoneNumber1,
        "phoneNumber2": phoneNumber2,
        "heros": List<dynamic>.from(heros.map((x) => x.toJson())),
      };
}

class Card {
  String title;
  String description;
  String backgroundImage;
  String tag;
  String url;
  bool isRelativeUrl;
  String id;
  String icon;

  Card({
    required this.title,
    required this.description,
    required this.backgroundImage,
    required this.tag,
    required this.url,
    required this.isRelativeUrl,
    required this.id,
    required this.icon,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        title: json["title"],
        description: json["description"],
        backgroundImage: json["backgroundImage"],
        tag: json["tag"],
        url: json["url"],
        isRelativeUrl: json["isRelativeUrl"],
        id: json["_id"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "backgroundImage": backgroundImage,
        "tag": tag,
        "url": url,
        "isRelativeUrl": isRelativeUrl,
        "_id": id,
        "icon": icon,
      };
}

class Footer {
  String title;
  List<NavLink> navLinks;
  String id;

  Footer({
    required this.title,
    required this.navLinks,
    required this.id,
  });

  factory Footer.fromJson(Map<String, dynamic> json) => Footer(
        title: json["title"],
        navLinks: List<NavLink>.from(
            json["navLinks"].map((x) => NavLink.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "navLinks": List<dynamic>.from(navLinks.map((x) => x.toJson())),
        "_id": id,
      };
}

class NavLink {
  String name;
  String link;
  bool isRelativeUrl;
  String id;

  NavLink({
    required this.name,
    required this.link,
    required this.isRelativeUrl,
    required this.id,
  });

  factory NavLink.fromJson(Map<String, dynamic> json) => NavLink(
        name: json["name"],
        link: json["link"],
        isRelativeUrl: json["isRelativeUrl"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
        "isRelativeUrl": isRelativeUrl,
        "_id": id,
      };
}

class HeroDta {
  String title;
  String description;
  String image;
  String place;
  String id;

  HeroDta({
    required this.title,
    required this.description,
    required this.image,
    required this.place,
    required this.id,
  });

  factory HeroDta.fromJson(Map<String, dynamic> json) => HeroDta(
        title: json["title"],
        description: json["description"],
        image: json["image"],
        place: json["place"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "place": place,
        "_id": id,
      };
}

class RecentBlog {
  String id;
  String title;
  String body;
  String thumbnail;
  RecentBlogCategory category;
  List<dynamic> tags;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  int v;

  RecentBlog({
    required this.id,
    required this.title,
    required this.body,
    required this.thumbnail,
    required this.category,
    required this.tags,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.v,
  });

  factory RecentBlog.fromJson(Map<String, dynamic> json) => RecentBlog(
        id: json["_id"],
        title: json["title"],
        body: json["body"],
        thumbnail: json["thumbnail"],
        category: RecentBlogCategory.fromJson(json["category"]),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "body": body,
        "thumbnail": thumbnail,
        "category": category.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "slug": slug,
        "__v": v,
      };
}

class RecentBlogCategory {
  String id;
  String categoryName;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  int v;

  RecentBlogCategory({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.v,
  });

  factory RecentBlogCategory.fromJson(Map<String, dynamic> json) =>
      RecentBlogCategory(
        id: json["_id"],
        categoryName: json["categoryName"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryName": categoryName,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "slug": slug,
        "__v": v,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}




// import 'all_attraction_modal.dart';

// class bestTopModel {
//   Home? home;
//   List<BestSellingAttractions>? bestSellingAttractions;
//   List<TopAttractions>? topAttractions;
//   List<RecentBlogs>? recentBlogs;

//   bestTopModel(
//       {this.home,
//       this.bestSellingAttractions,
//       this.topAttractions,
//       this.recentBlogs});

//   bestTopModel.fromJson(Map<String, dynamic> json) {
//     home = json['home'] != null ? Home.fromJson(json['home']) : null;
//     if (json['bestSellingAttractions'] != null) {
//       bestSellingAttractions = <BestSellingAttractions>[];
//       json['bestSellingAttractions'].forEach((v) {
//         bestSellingAttractions!.add(BestSellingAttractions.fromJson(v));
//       });
//     }
//     if (json['topAttractions'] != null) {
//       topAttractions = <TopAttractions>[];
//       json['topAttractions'].forEach((v) {
//         topAttractions!.add(TopAttractions.fromJson(v));
//       });
//     }
//     if (json['recentBlogs'] != null) {
//       recentBlogs = <RecentBlogs>[];
//       json['recentBlogs'].forEach((v) {
//         recentBlogs!.add(RecentBlogs.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (home != null) {
//       data['home'] = home!.toJson();
//     }
//     if (bestSellingAttractions != null) {
//       data['bestSellingAttractions'] =
//           bestSellingAttractions!.map((v) => v.toJson()).toList();
//     }
//     if (topAttractions != null) {
//       data['topAttractions'] = topAttractions!.map((v) => v.toJson()).toList();
//     }
//     if (recentBlogs != null) {
//       data['recentBlogs'] = recentBlogs!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Home {
//   String? sId;
//   int? settingsNumber;
//   int? iV;
//   List<String>? bestSellingAttractions;
//   List<Cards>? cards;
//   String? createdAt;
//   List<Footer>? footer;
//   List<String>? heroImages;
//   bool? isBestSellingAttractionsSectionEnabled;
//   bool? isBlogsEnabled;
//   bool? isTopAttractionsSectionEnabled;
//   String? logo;
//   List<String>? topAttractions;
//   String? updatedAt;
//   String? heroDescription;
//   String? heroTitle;
//   String? email;
//   String? facebookUrl;
//   String? footerDescription;
//   String? instagramUrl;
//   String? phoneNumber1;
//   String? phoneNumber2;
//   List<Heros>? heros;

//   Home(
//       {this.sId,
//       this.settingsNumber,
//       this.iV,
//       this.bestSellingAttractions,
//       this.cards,
//       this.createdAt,
//       this.footer,
//       this.heroImages,
//       this.isBestSellingAttractionsSectionEnabled,
//       this.isBlogsEnabled,
//       this.isTopAttractionsSectionEnabled,
//       this.logo,
//       this.topAttractions,
//       this.updatedAt,
//       this.heroDescription,
//       this.heroTitle,
//       this.email,
//       this.facebookUrl,
//       this.footerDescription,
//       this.instagramUrl,
//       this.phoneNumber1,
//       this.phoneNumber2,
//       this.heros});

//   Home.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     settingsNumber = json['settingsNumber'];
//     iV = json['__v'];
//     bestSellingAttractions = json['bestSellingAttractions'].cast<String>();
//     if (json['cards'] != null) {
//       cards = <Cards>[];
//       json['cards'].forEach((v) {
//         cards!.add(Cards.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     if (json['footer'] != null) {
//       footer = <Footer>[];
//       json['footer'].forEach((v) {
//         footer!.add(Footer.fromJson(v));
//       });
//     }
//     heroImages = json['heroImages'].cast<String>();
//     isBestSellingAttractionsSectionEnabled =
//         json['isBestSellingAttractionsSectionEnabled'];
//     isBlogsEnabled = json['isBlogsEnabled'];
//     isTopAttractionsSectionEnabled = json['isTopAttractionsSectionEnabled'];
//     logo = json['logo'];
//     topAttractions = json['topAttractions'].cast<String>();
//     updatedAt = json['updatedAt'];
//     heroDescription = json['heroDescription'];
//     heroTitle = json['heroTitle'];
//     email = json['email'];
//     facebookUrl = json['facebookUrl'];
//     footerDescription = json['footerDescription'];
//     instagramUrl = json['instagramUrl'];
//     phoneNumber1 = json['phoneNumber1'];
//     phoneNumber2 = json['phoneNumber2'];
//     if (json['heros'] != null) {
//       heros = <Heros>[];
//       json['heros'].forEach((v) {
//         heros!.add(Heros.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['settingsNumber'] = settingsNumber;
//     data['__v'] = iV;
//     data['bestSellingAttractions'] = bestSellingAttractions;
//     if (cards != null) {
//       data['cards'] = cards!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = createdAt;
//     if (footer != null) {
//       data['footer'] = footer!.map((v) => v.toJson()).toList();
//     }
//     data['heroImages'] = heroImages;
//     data['isBestSellingAttractionsSectionEnabled'] =
//         isBestSellingAttractionsSectionEnabled;
//     data['isBlogsEnabled'] = isBlogsEnabled;
//     data['isTopAttractionsSectionEnabled'] = isTopAttractionsSectionEnabled;
//     data['logo'] = logo;
//     data['topAttractions'] = topAttractions;
//     data['updatedAt'] = updatedAt;
//     data['heroDescription'] = heroDescription;
//     data['heroTitle'] = heroTitle;
//     data['email'] = email;
//     data['facebookUrl'] = facebookUrl;
//     data['footerDescription'] = footerDescription;
//     data['instagramUrl'] = instagramUrl;
//     data['phoneNumber1'] = phoneNumber1;
//     data['phoneNumber2'] = phoneNumber2;
//     if (heros != null) {
//       data['heros'] = heros!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Cards {
//   String? title;
//   String? description;
//   String? backgroundImage;
//   String? tag;
//   String? url;
//   bool? isRelativeUrl;
//   String? sId;
//   String? icon;

//   Cards(
//       {this.title,
//       this.description,
//       this.backgroundImage,
//       this.tag,
//       this.url,
//       this.isRelativeUrl,
//       this.sId,
//       this.icon});

//   Cards.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     backgroundImage = json['backgroundImage'];
//     tag = json['tag'];
//     url = json['url'];
//     isRelativeUrl = json['isRelativeUrl'];
//     sId = json['_id'];
//     icon = json['icon'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['description'] = description;
//     data['backgroundImage'] = backgroundImage;
//     data['tag'] = tag;
//     data['url'] = url;
//     data['isRelativeUrl'] = isRelativeUrl;
//     data['_id'] = sId;
//     data['icon'] = icon;
//     return data;
//   }
// }

// class Footer {
//   String? title;
//   List<NavLinks>? navLinks;
//   String? sId;

//   Footer({this.title, this.navLinks, this.sId});

//   Footer.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     if (json['navLinks'] != null) {
//       navLinks = <NavLinks>[];
//       json['navLinks'].forEach((v) {
//         navLinks!.add(NavLinks.fromJson(v));
//       });
//     }
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['title'] = title;
//     if (navLinks != null) {
//       data['navLinks'] = navLinks!.map((v) => v.toJson()).toList();
//     }
//     data['_id'] = sId;
//     return data;
//   }
// }

// class NavLinks {
//   String? name;
//   String? link;
//   bool? isRelativeUrl;
//   String? sId;

//   NavLinks({this.name, this.link, this.isRelativeUrl, this.sId});

//   NavLinks.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     link = json['link'];
//     isRelativeUrl = json['isRelativeUrl'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['link'] = link;
//     data['isRelativeUrl'] = isRelativeUrl;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class Heros {
//   String? title;
//   String? description;
//   String? image;
//   String? place;
//   String? sId;

//   Heros({this.title, this.description, this.image, this.place, this.sId});

//   Heros.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     image = json['image'];
//     place = json['place'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['description'] = description;
//     data['image'] = image;
//     data['place'] = place;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class BestSellingAttractions {
//   String? sId;
//   Destination? destination;
//   String? title;
//   Category? category;
//   String? bookingType;
//   List<String>? images;
//   String? slug;
//   Activity? activity;
//   int? totalReviews;
//   double? averageRating;

//   BestSellingAttractions(
//       {this.sId,
//       this.destination,
//       this.title,
//       this.category,
//       this.bookingType,
//       this.images,
//       this.slug,
//       this.activity,
//       this.totalReviews,
//       this.averageRating});

//   BestSellingAttractions.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     destination = json['destination'] != null
//         ? Destination.fromJson(json['destination'])
//         : null;
//     title = json['title'];
//     category =
//         json['category'] != null ? Category.fromJson(json['category']) : null;
//     bookingType = json['bookingType'];
//     images = json['images'].cast<String>();
//     slug = json['slug'];
//     activity =
//         json['activity'] != null ? Activity.fromJson(json['activity']) : null;
//     totalReviews = json['totalReviews'];
//     averageRating = json['averageRating'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     if (destination != null) {
//       data['destination'] = destination!.toJson();
//     }
//     data['title'] = title;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     data['bookingType'] = bookingType;
//     data['images'] = images;
//     data['slug'] = slug;
//     if (activity != null) {
//       data['activity'] = activity!.toJson();
//     }
//     data['totalReviews'] = totalReviews;
//     data['averageRating'] = averageRating;
//     return data;
//   }
// }

// class Destination {
//   String? name;

//   Destination({this.name});

//   Destination.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     return data;
//   }
// }

// // class Category {
// //   String? categoryName;
// //   String? slug;

// //   Category({this.categoryName, this.slug});

// //   Category.fromJson(Map<String, dynamic> json) {
// //     categoryName = json['categoryName'];
// //     slug = json['slug'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['categoryName'] = this.categoryName;
// //     data['slug'] = this.slug;
// //     return data;
// //   }
// // }

// class Activity {
//   int? adultPrice;

//   Activity({this.adultPrice});

//   Activity.fromJson(Map<String, dynamic> json) {
//     adultPrice = json['adultPrice'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['adultPrice'] = adultPrice;
//     return data;
//   }
// }

// class TopAttractions {
//   String? sId;
//   Destination? destination;
//   String? title;
//   Category? category;
//   String? bookingType;
//   List<String>? images;
//   String? slug;
//   Activity? activity;
//   int? totalReviews;
//   double? averageReviews;

//   TopAttractions(
//       {this.sId,
//       this.destination,
//       this.title,
//       this.category,
//       this.bookingType,
//       this.images,
//       this.slug,
//       this.activity,
//       this.totalReviews,
//       this.averageReviews});

//   TopAttractions.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     destination = json['destination'] != null
//         ? Destination.fromJson(json['destination'])
//         : null;
//     title = json['title'];
//     category =
//         json['category'] != null ? Category.fromJson(json['category']) : null;
//     bookingType = json['bookingType'];
//     images = json['images'].cast<String>();
//     slug = json['slug'];
//     activity =
//         json['activity'] != null ? Activity.fromJson(json['activity']) : null;
//     totalReviews = json['totalReviews'];
//     averageReviews = json['averageReviews'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     if (destination != null) {
//       data['destination'] = destination!.toJson();
//     }
//     data['title'] = title;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     data['bookingType'] = bookingType;
//     data['images'] = images;
//     data['slug'] = slug;
//     if (activity != null) {
//       data['activity'] = activity!.toJson();
//     }
//     data['totalReviews'] = totalReviews;
//     data['averageReviews'] = averageReviews;
//     return data;
//   }
// }

// class RecentBlogs {
//   String? sId;
//   String? title;
//   String? body;
//   String? thumbnail;
//   Category? category;
//   // List<Null>? tags;
//   // List<dynamic>? tags;
//   bool? isDeleted;
//   String? createdAt;
//   String? updatedAt;
//   String? slug;
//   int? iV;

//   RecentBlogs(
//       {this.sId,
//       this.title,
//       this.body,
//       this.thumbnail,
//       this.category,
//       // this.tags,
//       this.isDeleted,
//       this.createdAt,
//       this.updatedAt,
//       this.slug,
//       this.iV});

//   RecentBlogs.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     body = json['body'];
//     thumbnail = json['thumbnail'];
//     category =
//         json['category'] != null ? Category.fromJson(json['category']) : null;
//     // if (json['tags'] != null) {
//     //   tags = <Null>[];
//     //   json['tags'].forEach((v) {
//     //     tags!.add(new Null.fromJson(v));
//     //   });
//     // }
//     isDeleted = json['isDeleted'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     slug = json['slug'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['body'] = body;
//     data['thumbnail'] = thumbnail;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     // if (this.tags != null) {
//     //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
//     // }
//     data['isDeleted'] = isDeleted;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['slug'] = slug;
//     data['__v'] = iV;
//     return data;
//   }
// }

// // class Category {
// //   String? sId;
// //   String? categoryName;
// //   String? description;
// //   String? createdAt;
// //   String? updatedAt;
// //   String? slug;
// //   int? iV;

// //   Category(
// //       {this.sId,
// //       this.categoryName,
// //       this.description,
// //       this.createdAt,
// //       this.updatedAt,
// //       this.slug,
// //       this.iV});

// //   Category.fromJson(Map<String, dynamic> json) {
// //     sId = json['_id'];
// //     categoryName = json['categoryName'];
// //     description = json['description'];
// //     createdAt = json['createdAt'];
// //     updatedAt = json['updatedAt'];
// //     slug = json['slug'];
// //     iV = json['__v'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['_id'] = this.sId;
// //     data['categoryName'] = this.categoryName;
// //     data['description'] = this.description;
// //     data['createdAt'] = this.createdAt;
// //     data['updatedAt'] = this.updatedAt;
// //     data['slug'] = this.slug;
// //     data['__v'] = this.iV;
// //     return data;
// //   }
// // }
