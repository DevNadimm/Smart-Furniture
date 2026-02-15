import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/purchase_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/purchase_repository.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
    // Load all purchases
    on<LoadPurchasesEvent>((event, emit) async {
      emit(PurchaseLoading());
      try {
        final data = await PurchaseRepository.fetchPurchase();
        emit(PurchaseLoaded(data));
      } catch (e) {
        emit(PurchaseError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}