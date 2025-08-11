import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/sales/data/models/sales_record_model.dart';
import 'package:smart_furniture/features/sales/data/repositories/sales_record_repository.dart';

part 'sales_record_event.dart';
part 'sales_record_state.dart';

class SalesRecordBloc extends Bloc<SalesRecordEvent, SalesRecordState> {
  SalesRecordBloc() : super(SalesRecordInitial()) {
    on<LoadSalesRecordEvent>((event, emit) async {
      emit(SalesRecordLoading());
      try {
        final data = await SalesRecordRepository.fetchData(event.fromDate, event.toDate);
        emit(SalesRecordLoaded(data));
      } catch (e) {
        emit(SalesRecordError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
