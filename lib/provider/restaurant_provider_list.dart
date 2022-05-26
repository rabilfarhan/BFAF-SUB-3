import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:restaurant_app/utils/request_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchRestaurantList();
  }

  ListRestaurant? _listRestaurant;
  RequestState? _state;
  String _message = '';

  String get message => _message;

  ListRestaurant? get result => _listRestaurant;

  RequestState? get state => _state;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = RequestState.Loading;
      notifyListeners();
      final restaurantList = await apiService.listRestaurant();
      if (restaurantList.restaurants.isEmpty) {
        _state = RequestState.NoData;
        notifyListeners();
      } else {
        _state = RequestState.HasData;
        notifyListeners();
        return _listRestaurant = restaurantList;
      }
    } catch (e) {
      _state = RequestState.Error;
      notifyListeners();
    }
  }
}
