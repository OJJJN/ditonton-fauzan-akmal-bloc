part of 'migrate_tvls_top_rated_bloc.dart';

abstract class MigrateTvlsTopRatedState extends Equatable {
  const MigrateTvlsTopRatedState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsTopRatedEmpty extends MigrateTvlsTopRatedState {}

class MigrateTvlsTopRatedLoading extends MigrateTvlsTopRatedState {}

class MigrateTvlsTopRatedError extends MigrateTvlsTopRatedState {
  final String message;

  const MigrateTvlsTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsTopRatedLoaded extends MigrateTvlsTopRatedState {
  final List<Tvls> result;

  const MigrateTvlsTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}