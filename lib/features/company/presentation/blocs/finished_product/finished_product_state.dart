part of 'finished_product_bloc.dart';

@immutable
sealed class FinishedProductState {}

final class FinishedProductInitial extends FinishedProductState {}

final class FinishedProductLoading extends FinishedProductState {}

final class FinishedProductLoaded extends FinishedProductState {
  final List<FinishedProductData> finishedProducts;

  FinishedProductLoaded(this.finishedProducts);
}

final class FinishedProductError extends FinishedProductState {
  final String message;

  FinishedProductError(this.message);
}
