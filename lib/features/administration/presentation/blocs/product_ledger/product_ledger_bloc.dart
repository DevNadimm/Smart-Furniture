import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/administration/data/models/product_ledger_model.dart';
import 'package:smart_furniture/features/administration/data/repositories/product_ledger_repository.dart';

part 'product_ledger_event.dart';
part 'product_ledger_state.dart';

class ProductLedgerBloc extends Bloc<ProductLedgerEvent, ProductLedgerState> {
  ProductLedgerBloc() : super(ProductLedgerInitial()) {
    on<LoadProductLedgerEvent>((event, emit) async {
      emit(ProductLedgerLoading());
      try {
        final data = await ProductLedgerRepository.fetchData(
          productId: event.productId,
          fromDate: event.fromDate,
          toDate: event.toDate,
        );
        emit(ProductLedgerLoaded(data!));
      } catch (e) {
        emit(ProductLedgerError(e.toString()));
        emit(ProductLedgerInitial());
      }
    });

    on<ResetProductLedgerEvent>((event, emit) {
      emit(ProductLedgerInitial());
    });
  }
}
