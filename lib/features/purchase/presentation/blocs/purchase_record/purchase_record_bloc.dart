import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/purchase/data/models/purchase_record_model.dart';
import 'package:smart_furniture/features/purchase/data/repositories/purchase_record_repository.dart';

part 'purchase_record_event.dart';
part 'purchase_record_state.dart';

class PurchaseRecordBloc extends Bloc<PurchaseRecordEvent, PurchaseRecordState> {
  PurchaseRecordBloc() : super(PurchaseRecordInitial()) {
    on<LoadPurchaseRecordEvent>((event, emit) async {
      emit(PurchaseRecordLoading());
      try {
        final data = await PurchaseRecordRepository.fetchData(
            event.fromDate, event.toDate);
        emit(PurchaseRecordLoaded(data!));
      } catch (e) {
        emit(PurchaseRecordError(e.toString()));
      }
    });
  }
}
