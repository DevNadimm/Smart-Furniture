import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/administration/data/models/damage_list_model.dart';
import 'package:smart_furniture/features/administration/data/repositories/damage_list_repository.dart';

part 'damage_list_event.dart';
part 'damage_list_state.dart';

class DamageListBloc extends Bloc<DamageListEvent, DamageListState> {
  DamageListBloc() : super(DamageListInitial()) {
    on<LoadDamageListEvent>((event, emit) async {
      emit(DamageListLoading());
      try {
        final data = await DamageListRepository.fetchData(event.shop, event.productId);
        emit(DamageListLoaded(data!));
      } catch (e) {
        emit(DamageListError(HelperFunctions.cleanErrorMessage(e.toString())));
        emit(DamageListInitial());
      }
    });

    on<ResetDamageListEvent>((event, emit) {
      emit(DamageListInitial());
    });
  }
}
