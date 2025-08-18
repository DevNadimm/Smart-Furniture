import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/daily_reports/data/models/daily_reports_model.dart';
import 'package:smart_furniture/features/daily_reports/data/repositories/daily_reports_repository.dart';

part 'daily_reports_event.dart';
part 'daily_reports_state.dart';

class DailyReportsBloc extends Bloc<DailyReportsEvent, DailyReportsState> {
  DailyReportsBloc() : super(DailyReportsInitial()) {
    on<LoadDailyReportsEvent>((event, emit) async {
      emit(DailyReportsLoading());
      try {
        final data = await DailyReportsRepository.fetchData(event.shop, event.date);
        emit(DailyReportsLoaded(data!));
      } catch (e) {
        emit(DailyReportsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
