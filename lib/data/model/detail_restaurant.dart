import 'dart:convert';

class RestaurantDetail {
  final String error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      error: json['error'].toString(),
      message: json['message'] as String,
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }
}

List<RestaurantDetail> parseRestaurantDetail(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed
      .map<RestaurantDetail>((json) => RestaurantDetail.fromJson(json))
      .toList();
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  List<Categories> categories;
  final Menus menus;
  final String rating;
  List<CustomerReviews> customerReviews;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.city,
      required this.address,
      required this.pictureId,
      required this.categories,
      required this.menus,
      required this.rating,
      required this.customerReviews});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var category = json['categories'] as List;
    List<Categories> restoCategories =
        category.map((i) => Categories.fromJson(i)).toList();
    var customerReview = json['customerReviews'] as List;
    List<CustomerReviews> restoReviews =
        customerReview.map((i) => CustomerReviews.fromJson(i)).toList();
    return Restaurant(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        city: json['city'] as String,
        address: json['address'] as String,
        pictureId: json['pictureId'] as String,
        categories: restoCategories,
        menus: Menus.fromJson(json['menus']),
        rating: json['rating'].toString(),
        customerReviews: restoReviews);
  }
}

List<Restaurant> parseRestaurant(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
}

class Categories {
  final String name;

  Categories({required this.name});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(name: json['name']);
  }
}

List<Categories> parseCategories(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
}

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    var food = json['foods'] as List;
    List<Foods> foodList = food.map((i) => Foods.fromJson(i)).toList();
    var drink = json['drinks'] as List;
    List<Drinks> drinkList = drink.map((i) => Drinks.fromJson(i)).toList();
    return Menus(foods: foodList, drinks: drinkList);
  }
}

List<Menus> parseMenus(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map<Menus>((json) => Menus.fromJson(json)).toList();
}

class Foods {
  final String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
      name: json['name'] as String,
    );
  }
}

List<Foods> parseFoods(String json) {
  final List parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map((json) => Foods.fromJson(json)).toList();
}

class Drinks {
  final String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      name: json['name'] as String,
    );
  }
}

List<Drinks> parseDrinks(String json) {
  final List parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map((json) => Drinks.fromJson(json)).toList();
}

class CustomerReviews {
  final String name;
  final String review;
  final String date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) {
    return CustomerReviews(
        name: json['name'] as String,
        review: json['review'] as String,
        date: json['date'] as String);
  }
}

List<CustomerReviews> parseCustomerReviews(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed
      .map<CustomerReviews>((json) => CustomerReviews.fromJson(json))
      .toList();
}
