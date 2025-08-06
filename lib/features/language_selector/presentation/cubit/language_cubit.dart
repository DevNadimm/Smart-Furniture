import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';

class LanguageCubit extends Cubit<Locale> {

  LanguageCubit() : super(const Locale('en')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage () async {
    final savedCode = await AppPreferences.getSelectedLanguage();
    emit(Locale(savedCode));
  }

  Future<void> selectLanguage(String languageCode) async {
    await AppPreferences.setSelectedLanguage(languageCode);
    emit(Locale(languageCode));
  }
}
