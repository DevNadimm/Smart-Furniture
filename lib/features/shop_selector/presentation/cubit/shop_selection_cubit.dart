import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSelectionCubit extends Cubit<String> {
  ShopSelectionCubit() : super('');

  void selectShop (String shopId) => emit(shopId);
}