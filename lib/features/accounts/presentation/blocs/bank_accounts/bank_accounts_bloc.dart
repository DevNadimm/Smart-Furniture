import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/bank_accounts_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/bank_accounts_repository.dart';

part 'bank_accounts_event.dart';
part 'bank_accounts_state.dart';

class BankAccountsBloc extends Bloc<BankAccountsEvent, BankAccountsState> {
  BankAccountsBloc() : super(BankAccountsInitial()) {
    on<LoadBankAccountsEvent>((event, emit) async {
      emit(BankAccountsLoading());
      try {
        final data = await BankAccountsRepository.fetchData(event.shop);
        emit(BankAccountsLoaded(data!));
      } catch (e) {
        emit(BankAccountsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
