part of 'migrate_movie_watchlist_bloc.dart';

abstract class MigrateMovieWatchlistEvent extends Equatable {
  const MigrateMovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetListEvent extends MigrateMovieWatchlistEvent {}

class GetStatusMovieEvent extends MigrateMovieWatchlistEvent {
  final int id;

  const GetStatusMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetStatusTvEvent extends MigrateMovieWatchlistEvent {
  final int id;

  const GetStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemMovieEvent extends MigrateMovieWatchlistEvent {
  final MovieDetail movieDetail;

  const AddItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}


class RemoveItemMovieEvent extends MigrateMovieWatchlistEvent {
  final MovieDetail movieDetail;

  const RemoveItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
