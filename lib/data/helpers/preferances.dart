import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const restaurant_day = 'restaurant_day';

  Future<bool> get isDailyRestoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(restaurant_day) ?? false;
  }

  void setDailyResto(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(restaurant_day, value);
  }
}
