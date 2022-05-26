import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'dart:async';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_searching.dart';
import 'package:restaurant_app/utils/request_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  SearchRestaurant? _restaurantSearch;
  RequestState? _state;
  String _message = '';

  String get message => _message;
  SearchRestaurant? get result => _restaurantSearch;
  RequestState? get state => _state;
  Logger _logger = Logger();

  Future<dynamic> fecthRestaurantSearch(String query) async {
    try {
      _state = RequestState.Loading;
      notifyListeners();
      final restoSearch = await apiService.searchRestaurant(query);
      if (restoSearch.error.isEmpty) {
        _state = RequestState.NoData;
        notifyListeners();
      } else {
        _state = RequestState.HasData;
        notifyListeners();
        _logger.d(restoSearch.restaurants.length);
        return _restaurantSearch = restoSearch;
      }
    } catch (e) {
      _state = RequestState.Error;
      notifyListeners();
    }
  }
}
