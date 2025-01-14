part of 'get_all_products_cubit.dart';

sealed class GetAllProductsState extends Equatable {
  const GetAllProductsState();

  @override
  List<Object> get props => [];
}

final class GetAllProductsInitial extends GetAllProductsState {}

final class GetAllProductsLoading extends GetAllProductsState {}

final class GetAllProductsError extends GetAllProductsState {
  final String error;

  const GetAllProductsError({required this.error});
}

final class GetAllProductsSuccess extends GetAllProductsState {
  final List<Product> products;

  const GetAllProductsSuccess({required this.products});
}
