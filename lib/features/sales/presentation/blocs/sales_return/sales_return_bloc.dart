import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/sales/data/models/sales_return_model.dart';
import 'package:smart_furniture/features/sales/data/repositories/sales_return_repository.dart';

part 'sales_return_event.dart';
part 'sales_return_state.dart';

class SalesReturnBloc extends Bloc<SalesReturnEvent, SalesReturnState> {
  SalesReturnBloc() : super(SalesReturnInitial()) {
    on<LoadSalesReturnEvent>((event, emit) async {
      emit(SalesReturnLoading());
      try {
        final data = await SalesReturnRepository.fetchData(
          event.shop,
          event.fromDate,
          event.toDate,
          event.customerId,
        );
        emit(SalesReturnLoaded(data!));
      } catch (e) {
        emit(SalesReturnError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
