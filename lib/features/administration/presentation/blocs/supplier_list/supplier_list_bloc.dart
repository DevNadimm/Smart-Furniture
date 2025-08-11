import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/administration/data/models/supplier_list_model.dart';
import 'package:smart_furniture/features/administration/data/repositories/supplier_list_repository.dart';

part 'supplier_list_event.dart';
part 'supplier_list_state.dart';

class SupplierListBloc extends Bloc<SupplierListEvent, SupplierListState> {
  SupplierListBloc() : super(SupplierListInitial()) {
    on<LoadSupplierListEvent>((event, emit) async {
      emit(SupplierListLoading());
      try {
        final data = await SupplierListRepository.fetchData();
        emit(SupplierListLoaded(data!));
      } catch (e) {
        emit(SupplierListError(e.toString()));
      }
    });
  }
}
