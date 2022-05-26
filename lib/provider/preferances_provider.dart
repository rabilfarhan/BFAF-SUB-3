import 'package:flutter/material.dart';
import 'package:restaurant_app/data/helpers/preferances.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestoPreferences();
  }

  bool _isDailyRestoActive = false;
  bool get isDailyRestoActive => _isDailyRestoActive;

  void _getDailyRestoPreferences() async {
    _isDailyRestoActive = await preferencesHelper.isDailyRestoActive;
    notifyListeners();
  }

  void enableDailyResto(bool value) {
    preferencesHelper.setDailyResto(value);
    _getDailyRestoPreferences();
  }
}
