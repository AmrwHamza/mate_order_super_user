part of 'add_product_cubit.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object?> get props => [];
}

final class AddProductInitial extends AddProductState {}


class AddProductLoading extends AddProductState {}

class AddProductSuccess extends AddProductState {
  final AddProductModul product;

  const AddProductSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class AddProductError extends AddProductState {
  final String message;

  const AddProductError(this.message);

  @override
  List<Object?> get props => [message];
}