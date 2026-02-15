import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_dues_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/supplier_dues_repository.dart';

part 'supplier_dues_event.dart';
part 'supplier_dues_state.dart';

class SupplierDuesBloc extends Bloc<SupplierDuesEvent, SupplierDuesState> {
  SupplierDuesBloc() : super(SupplierDuesInitial()) {

    // Load all supplier dues
    on<LoadSupplierDuesEvent>((event, emit) async {
      emit(SupplierDuesLoading());
      try {
        final data = await SupplierDuesRepository.fetchSupplierDues();
        if (data != null) {
          emit(SupplierDuesLoaded(data));
        } else {
          emit(SupplierDuesError('Failed to fetch supplier dues'));
        }
      } catch (e) {
        emit(SupplierDuesError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}