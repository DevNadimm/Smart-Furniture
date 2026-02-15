import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/shop_selector/data/models/branch_model.dart';
import 'package:smart_furniture/features/shop_selector/data/repositories/branch_repository.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<LoadBranchesEvent>((event, emit) async {
      emit(BranchLoading());
      try {
        final data = await BranchRepository.fetchBranches();
        emit(BranchLoaded(data));
      } catch (e) {
        emit(BranchError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
