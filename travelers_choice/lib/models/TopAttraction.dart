class TopAttraction {
  String? image;
  String? types;
  String? rating;
  String? titlename;
  String? location;
  String? price;

  TopAttraction(
      {this.image,
      this.types,
      this.rating,
      this.titlename,
      this.location,
      this.price});

  factory TopAttraction.fromJson(Map<String, Object> json) {
    return TopAttraction(
      image: json['image'].toString(),
      types: json['types'].toString(),
      rating: json['rating'].toString(),
      titlename: json['titlename'].toString(),
      location: json['location'].toString(),
      price: json['price'].toString(),
    );
  }

  static map(TopAttraction Function(dynamic data) param0) {}
}
