import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/expense_head_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/expense_head_repository.dart';

part 'expense_head_event.dart';
part 'expense_head_state.dart';

class ExpenseHeadBloc extends Bloc<ExpenseHeadEvent, ExpenseHeadState> {
  ExpenseHeadBloc() : super(ExpenseHeadInitial()) {
    on<LoadExpenseHeadsEvent>((event, emit) async {
      emit(ExpenseHeadLoading());
      try {
        final data = await ExpenseHeadRepository.fetchExpenseHeads();
        emit(ExpenseHeadLoaded(data));
      } catch (e) {
        emit(ExpenseHeadError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
