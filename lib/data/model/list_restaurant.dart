import 'dart:convert';

class ListRestaurant {
  final String error;
  final String message;
  final String count;
  List<Restaurants> restaurants;

  ListRestaurant(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants});

  factory ListRestaurant.fromJson(Map<String, dynamic> json) {
    var resto = json['restaurants'] as List;
    List<Restaurants> restoList =
        resto.map((i) => Restaurants.fromJson(i)).toList();
    return ListRestaurant(
        error: json['error'].toString(),
        message: json['message'] as String,
        count: json['count'].toString(),
        restaurants: restoList);
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson()))
      };
}

List<ListRestaurant> parseListRestaurant(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed
      .map<ListRestaurant>((json) => ListRestaurant.fromJson(json))
      .toList();
}

class Restaurants {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;

  Restaurants(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating});

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return Restaurants(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        pictureId: json['pictureId'] as String,
        city: json['city'] as String,
        rating: json['rating'].toString());
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

List<Restaurants> parseRestaurants(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map<Restaurants>((json) => Restaurants.fromJson(json)).toList();
}
