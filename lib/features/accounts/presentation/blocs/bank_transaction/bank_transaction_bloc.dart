import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/bank_transaction_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/bank_transaction_repository.dart';

part 'bank_transaction_event.dart';
part 'bank_transaction_state.dart';

class BankTransactionBloc extends Bloc<BankTransactionEvent, BankTransactionState> {
  BankTransactionBloc() : super(BankTransactionInitial()) {
    on<LoadBankTransactionEvent>((event, emit) async {
      emit(BankTransactionLoading());
      try {
        final data = await BankTransactionRepository.fetchData(
          shop: event.shop,
          accountId: event.accountId,
          type: event.type,
          fromDate: event.fromDate,
          toDate: event.toDate,
        );
        emit(BankTransactionLoaded(data!));
      } catch (e) {
        emit(BankTransactionError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    on<ResetBankTransactionEvent>((event, emit) {
      emit(BankTransactionInitial());
    });
  }
}
