import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_expense_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/employee_expense_repository.dart';

part 'employee_expense_event.dart';
part 'employee_expense_state.dart';

class EmployeeExpenseBloc extends Bloc<EmployeeExpenseEvent, EmployeeExpenseState> {
  EmployeeExpenseBloc() : super(EmployeeExpenseInitial()) {
    // Load all expenses
    on<LoadEmployeeExpensesEvent>((event, emit) async {
      emit(EmployeeExpenseLoading());
      try {
        final data = await EmployeeExpenseRepository.fetchEmployeeExpenses();
        emit(EmployeeExpenseLoaded(data!));
      } catch (e) {
        emit(EmployeeExpenseError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Create new expense
    on<CreateEmployeeExpenseEvent>((event, emit) async {
      emit(EmployeeExpenseOperationLoading());
      try {
        final result = await EmployeeExpenseRepository.createEmployeeExpense(event.expenseData);
        if (result) {
          emit(EmployeeExpenseOperationSuccess('Expense created successfully'));
          // Reload expenses after creation
          add(LoadEmployeeExpensesEvent());
        } else {
          emit(EmployeeExpenseError('Failed to create expense'));
        }
      } catch (e) {
        emit(EmployeeExpenseError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Update existing expense
    on<UpdateEmployeeExpenseEvent>((event, emit) async {
      emit(EmployeeExpenseOperationLoading());
      try {
        final result = await EmployeeExpenseRepository.updateEmployeeExpense(
          event.id,
          event.expenseData,
        );
        if (result) {
          emit(EmployeeExpenseOperationSuccess('Expense updated successfully'));
          // Reload expenses after update
          add(LoadEmployeeExpensesEvent());
        } else {
          emit(EmployeeExpenseError('Failed to update expense'));
        }
      } catch (e) {
        emit(EmployeeExpenseError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Delete expense
    on<DeleteEmployeeExpenseEvent>((event, emit) async {
      emit(EmployeeExpenseOperationLoading());
      try {
        final result = await EmployeeExpenseRepository.deleteEmployeeExpense(event.id);
        if (result) {
          emit(EmployeeExpenseOperationSuccess('Expense deleted successfully'));
          // Reload expenses after deletion
          add(LoadEmployeeExpensesEvent());
        } else {
          emit(EmployeeExpenseError('Failed to delete expense'));
        }
      } catch (e) {
        emit(EmployeeExpenseError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}