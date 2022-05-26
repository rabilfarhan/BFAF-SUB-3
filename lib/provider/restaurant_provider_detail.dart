import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/utils/request_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService, required String id}) {
    _fetchRestaurantDetail(id);
  }

  RestaurantDetail? _restaurantDetail;
  RequestState? _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail? get result => _restaurantDetail;
  RequestState? get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = RequestState.Loading;
      notifyListeners();
      final restoDetail = await apiService.detailRestaurant(id);
      if (restoDetail.error.isEmpty) {
        _state = RequestState.NoData;
        notifyListeners();
      } else {
        _state = RequestState.HasData;
        notifyListeners();
        return _restaurantDetail = restoDetail;
      }
    } catch (e) {
      _state = RequestState.Error;
      notifyListeners();
    }
  }
}
