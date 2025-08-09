import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/sales/data/models/stock_model.dart';
import 'package:smart_furniture/features/sales/data/repositories/stock_repository.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockInitial()) {
    on<LoadStockEvent>((event, emit) async {
      emit(StockLoading());
      try {
        final data = await StockRepository.fetchData(
          event.fromDate,
          event.toDate,
          event.search,
        );

        emit(StockLoaded(data!));
      } catch (e) {
        emit(StockError(e.toString()));
      }
    });
  }
}
