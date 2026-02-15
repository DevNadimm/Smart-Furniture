import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/shop_selector/data/models/branch_model.dart';

class ShopSelectionCubit extends Cubit<BranchData?> {
  ShopSelectionCubit() : super(null);

  void selectBranch(BranchData branch) {
    emit(branch);
  }

  void clearSelection() {
    emit(null);
  }
}