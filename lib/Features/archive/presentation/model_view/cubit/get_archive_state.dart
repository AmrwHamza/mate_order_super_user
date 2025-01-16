part of 'get_archive_cubit.dart';

sealed class GetArchiveState extends Equatable {
  const GetArchiveState();

  @override
  List<Object> get props => [];
}

final class GetArchiveInitial extends GetArchiveState {}

final class GetArchiveLoading extends GetArchiveState {}

final class GetArchiveSuccess extends GetArchiveState {
  final List<Product> products;

  const GetArchiveSuccess({required this.products});
}

final class GetArchiveError extends GetArchiveState {
  final String message;

  const GetArchiveError({required this.message});
}
