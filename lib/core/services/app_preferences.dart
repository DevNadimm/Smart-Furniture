import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_furniture/core/constants/preference_keys.dart';

class AppPreferences {
  AppPreferences._();

  // First Time User
  static Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isFirstTimeUser) ?? true;
  }

  static Future<void> markFirstTimeCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceKeys.isFirstTimeUser, false);
  }

  // Language
  static Future<String> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.selectedLanguage) ?? 'en';
  }

  static Future<void> setSelectedLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.selectedLanguage, code);
  }

  // User Type (Admin / Employee)
  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userType);
  }

  static Future<void> setUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.userType, userType);
  }

  static Future<bool> hasUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(PreferenceKeys.userType);
  }

  // Authentication
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isLoggedIn) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceKeys.isLoggedIn, value);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userId);
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.userId, userId);
  }

  // User Basic Info (Optional)
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userName);
  }

  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.userName, name);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userEmail);
  }

  static Future<void> setUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.userEmail, email);
  }

  // Clear
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
