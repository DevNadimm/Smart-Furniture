import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';

class UserRoleCubit extends Cubit<String?> {
  UserRoleCubit() : super(null) {
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final role = await AppPreferences.getUserType();
    emit(role);
  }

  Future<void> selectUserRole(String role) async {
    await AppPreferences.setUserType(role);
    emit(role);
  }
}
