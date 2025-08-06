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

  static Future<String> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.selectedLanguage) ?? 'en';
  }

  static Future<void> setSelectedLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.selectedLanguage, code);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
