import 'package:flutter/material.dart';
import 'package:restaurant_app/data/helpers/database_helper.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:restaurant_app/utils/request_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late RequestState _state;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _favorites = [];
  List<Restaurants> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.length > 0) {
      _state = RequestState.HasData;
    } else {
      _state = RequestState.NoData;
      _message = 'Restaurant Favorite Kamu\nBelum Ada';
    }
    notifyListeners();
  }

  void addFavorites(Restaurants restaurants) async {
    try {
      await databaseHelper.insertFavorite(restaurants);
      _getFavorites();
    } catch (e) {
      _state = RequestState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = RequestState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
