import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class BookmarkNotifer extends ChangeNotifier {
  List<Restaurant> _bookmark = [];

  List<Restaurant> get bookmark => _bookmark;

  set bookmark(List<Restaurant> bookmark) {
    _bookmark = bookmark;
    notifyListeners();
  }

  setRestaurant(Restaurant restaurant) {
    if (!isBookmark(restaurant)) {
      _bookmark.add(restaurant);
    } else {
      _bookmark.removeWhere((element) => element.id == restaurant.id);
    }
    notifyListeners();
  }

  isBookmark(Restaurant restaurant) {
    var index = _bookmark.indexWhere((element) => element.id == restaurant.id);

    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }
}
