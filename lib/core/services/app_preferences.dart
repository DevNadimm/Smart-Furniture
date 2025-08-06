import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_furniture/core/constants/preference_keys.dart';

class AppPreferences {
  AppPreferences._();

  static Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isFirstTimeUser) ?? true;
  }

  static Future<void> markFirstTimeCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferenceKeys.isFirstTimeUser, false);
  }

  static Future<void> deleteFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceKeys.isFirstTimeUser);
  }
}
