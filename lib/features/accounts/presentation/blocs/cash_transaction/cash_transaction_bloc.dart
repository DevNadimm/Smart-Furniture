import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/cash_transaction_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/cash_transaction_repository.dart';

part 'cash_transaction_event.dart';
part 'cash_transaction_state.dart';

class CashTransactionBloc extends Bloc<CashTransactionEvent, CashTransactionState> {
  CashTransactionBloc() : super(CashTransactionInitial()) {
    on<LoadCashTransactionEvent>((event, emit) async {
      emit(CashTransactionLoading());
      try {
        final data = await CashTransactionRepository.fetchData(event.shop, event.type, event.fromDate, event.toDate);
        emit(CashTransactionLoaded(data!));
      } catch (e) {
        emit(CashTransactionError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    on<ResetCashTransactionEvent>((event, emit) {
      emit(CashTransactionInitial());
    });
  }
}
