import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/features/administration/data/models/customer_list_model.dart';
import 'package:smart_furniture/features/administration/data/repositories/customer_list_repository.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  CustomerListBloc() : super(CustomerListInitial()) {
    on<LoadCustomerListEvent>((event, emit) async {
      emit(CustomerListLoading());
      try {
        final data = await CustomerListRepository.fetchData();
        emit(CustomerListLoaded(data!));
      } catch (e) {
        emit(CustomerListError(e.toString()));
      }
    });
  }
}
