part of 'delete_cubit_cubit.dart';

sealed class DeleteCubitState extends Equatable {
  const DeleteCubitState();

  @override
  List<Object> get props => [];
}

final class DeleteCubitInitial extends DeleteCubitState {}

final class DeleteCubitLoading extends DeleteCubitState {}

final class DeleteCubitSuccess extends DeleteCubitState {
  final String message;

  const DeleteCubitSuccess({required this.message});
}

final class DeleteCubitError extends DeleteCubitState {
  final String message;

  const DeleteCubitError({required this.message});
}
