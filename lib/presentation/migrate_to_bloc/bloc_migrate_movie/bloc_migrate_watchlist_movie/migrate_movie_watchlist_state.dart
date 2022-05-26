part of 'migrate_movie_watchlist_bloc.dart';

abstract class MigrateMovieWatchlistState extends Equatable {
  const MigrateMovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MigrateMovieWatchlistEmpty extends MigrateMovieWatchlistState {}

class MigrateMovieWatchlistLoading extends MigrateMovieWatchlistState {}

class MigrateMovieWatchlistError extends MigrateMovieWatchlistState {
  final String message;

  const MigrateMovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieWatchlistSuccess extends MigrateMovieWatchlistState {
  final String message;

  const MigrateMovieWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieWatchlistLoaded extends MigrateMovieWatchlistState {
  final List<Movie> result;

  const MigrateMovieWatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MigrateMovieWatchlistStatusLoaded extends MigrateMovieWatchlistState {
  final bool result;

  const MigrateMovieWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}