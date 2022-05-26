part of 'migrate_tvls_search_bloc.dart';

abstract class MigrateTvlsSearchState extends Equatable {
  const MigrateTvlsSearchState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsSearchEmpty extends MigrateTvlsSearchState {}

class MigrateTvlsSearchLoading extends MigrateTvlsSearchState {}

class MigrateTvlsSearchError extends MigrateTvlsSearchState {
  final String message;

  const MigrateTvlsSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsSearchLoaded extends MigrateTvlsSearchState {
  final List<Tvls> result;

  const MigrateTvlsSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}