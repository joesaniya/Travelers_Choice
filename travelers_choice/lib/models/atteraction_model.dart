import 'Country_modal.dart';

class DetailattractionModal {
  String? sId;
  Destination? destination;
  String? title;
  Category? category;
  String? bookingType;
  String? startDate;
  String? endDate;
  List<dynamic>? offDays;
  String? durationType;
  int? duration;
  bool? isActive;
  String? latitude;
  String? longitude;
  bool? isOffer;
  String? offerAmountType;
  int? offerAmount;
  String? youtubeLink;
  List<String>? images;
  String? highlights;
  List<Sections>? sections;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isDeleted;
  List<Availability>? availability;
  dynamic? cancelBeforeTime;
  dynamic? cancellationFee;
  String? cancellationType;
  List<Faqs>? faqs;
  bool? isApiConnected;
  bool? isCombo;
  bool? isCustomDate;
  String? mapLink;
  List<dynamic>? offDates;
  List<Reviews>? reviews;
  Markup? markup;
// <<<<<<< HEAD
  dynamic totalRating;

  dynamic averageRating;
  List<Activity>? activities;

  DetailattractionModal({
    this.sId,
    this.destination,
    this.title,
    this.category,
    this.bookingType,
    this.startDate,
    this.endDate,
    this.offDays,
    this.durationType,
    this.duration,
    this.isActive,
    this.latitude,
    this.longitude,
    this.isOffer,
    this.offerAmountType,
    this.offerAmount,
    this.youtubeLink,
    this.images,
    this.highlights,
    this.sections,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.isDeleted,
    this.availability,
    this.cancelBeforeTime,
    this.cancellationFee,
    this.cancellationType,
    this.faqs,
    this.isApiConnected,
    this.isCombo,
    this.isCustomDate,
    this.mapLink,
    this.offDates,
    this.reviews,
    this.markup,
    this.totalRating,
    this.averageRating,
    this.activities,
  });

  DetailattractionModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    destination = json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
    title = json['title'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    bookingType = json['bookingType'];
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    if (json['offDays'] != null) {
      offDays = [];
      json['offDays'].forEach((v) {
        // offDays!.add(new Null.fromJson(v));
      });
    }
    durationType = json['durationType'];
    duration = json['duration'];
    isActive = json['isActive'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isOffer = json['isOffer'];
    offerAmountType = json['offerAmountType'];
    offerAmount = json['offerAmount'];
    youtubeLink = json['youtubeLink'];
    images = json['images'].cast<String>();
    highlights = json['highlights'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isDeleted = json['isDeleted'];
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(Availability.fromJson(v));
      });
    }
    cancelBeforeTime = json['cancelBeforeTime'] ?? '';
    cancellationFee = json['cancellationFee'] ?? '';
    cancellationType = json['cancellationType'];
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faqs.fromJson(v));
      });
    }
    isApiConnected = json['isApiConnected'];
    isCombo = json['isCombo'];
    isCustomDate = json['isCustomDate'];
    mapLink = json['mapLink'];
    if (json['offDates'] != null) {
      offDates = <dynamic>[];
      json['offDates'].forEach((v) {
        // offDates!.add(new Null.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    markup = json['markup'] != null ? Markup.fromJson(json['markup']) : null;
    totalRating = json['totalRating'];
    averageRating = json['averageRating'];
    if (json['activities'] != null) {
      activities = <Activity>[];
      json['activities'].forEach((v) {
        activities!.add(Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    data['title'] = title;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['bookingType'] = bookingType;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    if (offDays != null) {
      data['offDays'] = offDays!.map((v) => v!.toJson()).toList();
    }
    data['durationType'] = durationType;
    data['duration'] = duration;
    data['isActive'] = isActive;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isOffer'] = isOffer;
    data['offerAmountType'] = offerAmountType;
    data['offerAmount'] = offerAmount;
    data['youtubeLink'] = youtubeLink;
    data['images'] = images;
    data['highlights'] = highlights;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isDeleted'] = isDeleted;
    if (availability != null) {
      data['availability'] = availability!.map((v) => v.toJson()).toList();
    }
    data['cancelBeforeTime'] = cancelBeforeTime;
    data['cancellationFee'] = cancellationFee;
    data['cancellationType'] = cancellationType;
    if (faqs != null) {
      data['faqs'] = faqs!.map((v) => v.toJson()).toList();
    }
    data['isApiConnected'] = isApiConnected;
    data['isCombo'] = isCombo;
    data['isCustomDate'] = isCustomDate;
    data['mapLink'] = mapLink;
    if (offDates != null) {
      data['offDates'] = offDates!.map((v) => v!.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (markup != null) {
      data['markup'] = markup!.toJson();
    }
    data['totalRating'] = totalRating;
    data['averageRating'] = averageRating;
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  String? question;
  String? answer;
  String? sId;

  Faqs({this.question, this.answer, this.sId});

  Faqs.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    data['_id'] = sId;
    return data;
  }
}

// class Destination {
//   String? sId;
//   String? country;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   bool? isDeleted;
//   String? image;

//   Destination(
//       {this.sId,
//       this.country,
//       this.name,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.isDeleted,
//       this.image});

//   Destination.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     country = json['country'];
//     name = json['name'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     isDeleted = json['isDeleted'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['country'] = country;
//     data['name'] = name;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['isDeleted'] = isDeleted;
//     data['image'] = image;
//     return data;
//   }
// }

class Category {
  String? sId;
  String? categoryName;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? slug;
  int? iV;
  String? icon;

  Category(
      {this.sId,
      this.categoryName,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.iV,
      this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    iV = json['__v'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['slug'] = slug;
    data['__v'] = iV;
    data['icon'] = icon;
    return data;
  }
}

class Sections {
  String? title;
  String? body;
  String? sId;

  Sections({this.title, this.body, this.sId});

  Sections.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['_id'] = sId;
    return data;
  }
}

class Availability {
  bool? isEnabled;
  String? day;
  String? open;
  String? close;
  String? sId;

  Availability({this.isEnabled, this.day, this.open, this.close, this.sId});

  Availability.fromJson(Map<String, dynamic> json) {
    isEnabled = json['isEnabled'];
    day = json['day'];
    open = json['open'];
    close = json['close'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isEnabled'] = isEnabled;
    data['day'] = day;
    data['open'] = open;
    data['close'] = close;
    data['_id'] = sId;
    return data;
  }
}

class Reviews {
  String? sId;
  String? title;
  String? description;
  dynamic? rating;
  String? attraction;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reviews(
      {this.sId,
      this.title,
      this.description,
      this.rating,
      this.attraction,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    rating = json['rating'];
    attraction = json['attraction'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['rating'] = rating;
    data['attraction'] = attraction;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Markup {
  String? sId;
  String? attraction;
  int? iV;
  String? createdAt;
  int? markup;
  String? markupType;
  String? updatedAt;

  Markup(
      {this.sId,
      this.attraction,
      this.iV,
      this.createdAt,
      this.markup,
      this.markupType,
      this.updatedAt});

  Markup.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    attraction = json['attraction'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    markup = json['markup'];
    markupType = json['markupType'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['attraction'] = attraction;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['markup'] = markup;
    data['markupType'] = markupType;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Activity {
  String? sId;
  String? attraction;
  String? name;
  String? facilities; //no
  int? adultAgeLimit;
  int? adultPrice;
  dynamic childAgeLimit;
  int? childPrice;
  dynamic infantAgeLimit;
  int? infantPrice;
  bool? isVat;
  dynamic? vat;
  String? base;
  bool? isTransferAvailable;
  int? privateTransferPrice;
  int? sharedTransferPrice;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isDeleted;
  dynamic adultCost;
  dynamic childCost;
  dynamic infantCost;
  int adultCount = 1;
  int childCount = 0;
  int infantCount = 0;
  double totalAmount = 0;
  double grandTotal = 0;
  bool isPrivate = false;
  bool isSharing = false;
  //new
  String? activityType;
  String? description;
  bool? isSharedTransferAvailable;
  bool? isPrivateTransferAvailable;
  List<PrivateTransfers>? privateTransfers;
  String? transferType = 'private';

  int? sharedTransferCost;
  dynamic? lowPrice;
  String? selectedDate;

  double GrandTotalAmount = 0.0;
  bool expand = true;

  Activity(
      {this.sId,
      this.attraction,
      this.name,
      this.facilities,
      this.adultAgeLimit,
      this.adultPrice,
      this.childAgeLimit,
      this.childPrice,
      this.infantAgeLimit,
      this.infantPrice,
      this.isVat,
      this.vat,
      this.base,
      this.isTransferAvailable,
      this.privateTransferPrice,
      this.sharedTransferPrice,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isDeleted,
      this.adultCost,
      this.childCost,
      this.infantCost,
      this.adultCount = 1,
      this.childCount = 0,
      this.infantCount = 0,
      this.totalAmount = 0,
      this.grandTotal = 0,
      this.isPrivate = false,
      this.isSharing = false,
      this.activityType,
      this.description,
      this.isPrivateTransferAvailable,
      this.isSharedTransferAvailable,
      this.privateTransfers,
      this.sharedTransferCost,
      this.lowPrice,
      this.selectedDate,
      this.GrandTotalAmount = 0.0,
      this.transferType = 'private',
      this.expand = true});

  Activity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    attraction = json['attraction'];
    name = json['name'];
    facilities = json['facilities'];
    adultAgeLimit = json['adultAgeLimit'];
    adultPrice = json['adultPrice'];
    childAgeLimit = json['childAgeLimit'];
    childPrice = json['childPrice'];
    infantAgeLimit = json['infantAgeLimit'];
    infantPrice = json['infantPrice'];
    isVat = json['isVat'];
    vat = json['vat'];
    base = json['base'];
    isTransferAvailable = json['isTransferAvailable'];
    privateTransferPrice = json['privateTransferPrice'];
    sharedTransferPrice = json['sharedTransferPrice'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isDeleted = json['isDeleted'];
    adultCost = json['adultCost'] ?? 0.0;
    childCost = json['childCost'] ?? 0.0;
    infantCost = json['infantCost'] ?? 0.0;
    adultCount = 1;
    childCount = 0;
    infantCount = 0;
    grandTotal = 0;
    activityType = json["activityType"]; //:
    description = json["description"]; //:->=
    isSharedTransferAvailable = json['isSharedTransferAvailable'];
    isPrivateTransferAvailable = json['isPrivateTransferAvailable'];
    if (json['privateTransfers'] != null) {
      privateTransfers = <PrivateTransfers>[];
      json['privateTransfers'].forEach((v) {
        privateTransfers!.add(PrivateTransfers.fromJson(v));
      });
    }
    sharedTransferCost = json["sharedTransferCost"];
    lowPrice = json['lowPrice'];
    selectedDate = json['selectedDate'];
    GrandTotalAmount = 0.0;
    transferType = 'private';
    // transferType = json['transferType'] ?? 'private';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['attraction'] = attraction;
    data['name'] = name;
    data['facilities'] = facilities;
    data['adultAgeLimit'] = adultAgeLimit;
    data['adultPrice'] = adultPrice;
    data['childAgeLimit'] = childAgeLimit;
    data['childPrice'] = childPrice;
    data['infantAgeLimit'] = infantAgeLimit;
    data['infantPrice'] = infantPrice;
    data['isVat'] = isVat;
    data['vat'] = vat;
    data['base'] = base;
    data['isTransferAvailable'] = isTransferAvailable;
    data['privateTransferPrice'] = privateTransferPrice;
    data['sharedTransferPrice'] = sharedTransferPrice;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isDeleted'] = isDeleted;
    data['adultCost'] = adultCost;
    data['childCost'] = childCost;
    data['infantCost'] = infantCost;
    data['activityType'] = activityType;
    data['description'] = description;
    data['isSharedTransferAvailable'] = isSharedTransferAvailable;
    data['isPrivateTransferAvailable'] = isPrivateTransferAvailable;
    if (privateTransfers != null) {
      data['privateTransfers'] =
          privateTransfers!.map((v) => v.toJson()).toList();
    }
    data['sharedTransferCost'] = sharedTransferCost;
    data['lowPrice'] = lowPrice;
    data['selectedDate'] = selectedDate;
    data['transferType'] = transferType;
    return data;
  }
}

class PrivateTransfers {
  String? name;
  int? maxCapacity;
  dynamic price;
  int? cost;
  String? sId;

  PrivateTransfers(
      {this.name, this.maxCapacity, this.price, this.cost, this.sId});

  PrivateTransfers.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    maxCapacity = json['maxCapacity'] ?? '';
    price = json['price'] ?? '';
    cost = json['cost'] ?? '';
    sId = json['_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['maxCapacity'] = maxCapacity;
    data['price'] = price;
    data['cost'] = cost;
    data['_id'] = sId;
    return data;
  }
}
