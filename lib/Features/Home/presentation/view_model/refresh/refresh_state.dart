part of 'refresh_cubit.dart';

sealed class RefreshState extends Equatable {
  const RefreshState();

  @override
  List<Object> get props => [];
}

final class RefreshInitial extends RefreshState {}

final class RefreshLoading extends RefreshState {}

final class RefreshSuccess extends RefreshState {
  final RefreshModul r;

  const RefreshSuccess({required this.r});
}

final class RefreshError extends RefreshState {
  final String message;

  const RefreshError({required this.message});

}
