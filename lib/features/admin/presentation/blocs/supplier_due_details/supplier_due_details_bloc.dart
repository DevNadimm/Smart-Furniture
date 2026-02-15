import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_dues_details_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/supplier_dues_repository.dart';

part 'supplier_due_details_event.dart';
part 'supplier_due_details_state.dart';

class SupplierDueDetailsBloc extends Bloc<SupplierDueDetailsEvent, SupplierDueDetailsState> {
  SupplierDueDetailsBloc() : super(SupplierDueDetailsInitial()) {

    // Load supplier purchase dues by supplier ID
    on<LoadSupplierPurchaseDuesEvent>((event, emit) async {
      emit(SupplierDueDetailsLoading());
      try {
        final data = await SupplierDuesRepository.fetchSupplierWisePurchaseDues(event.supplierId);
        if (data != null) {
          emit(SupplierDueDetailsLoaded(data));
        } else {
          emit(SupplierDueDetailsError('Failed to fetch supplier purchase dues'));
        }
      } catch (e) {
        emit(SupplierDueDetailsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}