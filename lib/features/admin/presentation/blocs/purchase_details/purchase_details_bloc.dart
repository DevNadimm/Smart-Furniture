import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/purchase_details_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/purchase_repository.dart';

part 'purchase_details_event.dart';
part 'purchase_details_state.dart';

class PurchaseDetailsBloc extends Bloc<PurchaseDetailsEvent, PurchaseDetailsState> {
  PurchaseDetailsBloc() : super(PurchaseDetailsInitial()) {
    on<LoadPurchaseDetailsEvent>((event, emit) async {
      emit(PurchaseDetailsLoading());
      try {
        final data = await PurchaseRepository.fetchPurchaseDetails(event.purchaseId);
        if (data != null) {
          emit(PurchaseDetailsLoaded(data));
        } else {
          emit(PurchaseDetailsError('Purchase details not found'));
        }
      } catch (e) {
        emit(PurchaseDetailsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
