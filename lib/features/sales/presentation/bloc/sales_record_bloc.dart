import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'sales_record_event.dart';
part 'sales_record_state.dart';

class SalesRecordBloc extends Bloc<SalesRecordEvent, SalesRecordState> {
  SalesRecordBloc() : super(SalesRecordInitial()) {
    on<LoadSalesRecordEvent>((event, emit) async {
      emit(SalesRecordLoading());

      try {

      } catch (e) {

      }
    });
  }
}
