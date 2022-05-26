part of 'migrate_tvls_watchlist_bloc.dart';

abstract class MigrateTvlsWatchlistState extends Equatable {
  const MigrateTvlsWatchlistState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsWatchlistEmpty extends MigrateTvlsWatchlistState {}

class MigrateTvlsWatchlistLoading extends MigrateTvlsWatchlistState {}

class MigrateTvlsWatchlistError extends MigrateTvlsWatchlistState {
  final String message;

  const MigrateTvlsWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsWatchlistSuccess extends MigrateTvlsWatchlistState {
  final String message;

  const MigrateTvlsWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsWatchlistLoaded extends MigrateTvlsWatchlistState {
  final List<Tvls> result;

  const MigrateTvlsWatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MigrateTvlsWatchlistStatusLoaded extends MigrateTvlsWatchlistState {
  final bool result;

  const MigrateTvlsWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}