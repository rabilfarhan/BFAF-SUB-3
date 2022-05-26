import 'dart:convert';

import 'package:restaurant_app/data/model/list_restaurant.dart';

class SearchRestaurant {
  final String error;
  final String founded;
  List<Restaurants> restaurants;

  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) {
    var resto = json['restaurants'] as List;
    List<Restaurants> restoSearch =
        resto.map((i) => Restaurants.fromJson(i)).toList();
    return SearchRestaurant(
        error: json['error'].toString(),
        founded: json['founded'].toString(),
        restaurants: restoSearch);
  }
}

List<Restaurants> parseSearchRestaurants(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed
      .map<SearchRestaurant>((json) => SearchRestaurant.fromJson(json))
      .toList();
}
