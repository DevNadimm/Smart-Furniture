import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/reminder_cheque_list_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/reminder_cheque_list_repository.dart';

part 'reminder_cheque_list_event.dart';
part 'reminder_cheque_list_state.dart';

class ReminderChequeListBloc extends Bloc<ReminderChequeListEvent, ReminderChequeListState> {
  ReminderChequeListBloc() : super(ReminderChequeListInitial()) {
    on<LoadReminderChequeListEvent>((event, emit) async {
      emit(ReminderChequeListLoading());
      try {
        final data = await ReminderChequeListRepository.fetchData(event.shop);
        emit(ReminderChequeListLoaded(data!));
      } catch (e) {
        emit(ReminderChequeListError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
