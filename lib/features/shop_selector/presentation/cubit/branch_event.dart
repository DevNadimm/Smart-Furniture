part of 'branch_bloc.dart';

@immutable
sealed class BranchEvent {}

class LoadBranchesEvent extends BranchEvent {}
