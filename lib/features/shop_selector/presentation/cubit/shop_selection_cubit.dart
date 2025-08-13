import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop_type.dart';

class ShopSelectionCubit extends Cubit<ShopType?> {
  ShopSelectionCubit() : super(null);

  /// Select a shop
  void selectShop(ShopType shop) => emit(shop);

  /// Get the currently selected shop
  ShopType? get currentShop => state;
}
