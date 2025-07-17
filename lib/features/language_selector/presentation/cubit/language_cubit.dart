import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  static const _key = 'selectedLanguage';

  LanguageCubit() : super(const Locale('en')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage () async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_key) ?? 'en';
    emit(Locale(savedCode));
  }

  Future<void> selectLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);
    emit(Locale(languageCode));
  }
}
