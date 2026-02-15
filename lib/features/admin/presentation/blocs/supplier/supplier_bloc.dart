import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/supplier_repository.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(SupplierInitial()) {
    // Load all suppliers
    on<LoadSuppliersEvent>((event, emit) async {
      emit(SupplierLoading());
      try {
        final data = await SupplierRepository.fetchSuppliers();
        emit(SupplierLoaded(data));
      } catch (e) {
        emit(SupplierError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}