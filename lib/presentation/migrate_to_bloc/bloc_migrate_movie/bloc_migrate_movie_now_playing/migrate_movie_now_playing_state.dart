part of 'migrate_movie_now_playing_bloc.dart';

abstract class MigrateMovieNowPlayingState extends Equatable {
  const MigrateMovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MigrateMovieNowPlayingEmpty extends MigrateMovieNowPlayingState {}

class MigrateMovieNowPlayingLoading extends MigrateMovieNowPlayingState {}

class MigrateMovieNowPlayingError extends MigrateMovieNowPlayingState {
  final String message;

  const MigrateMovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieNowPlayingLoaded extends MigrateMovieNowPlayingState {
  final List<Movie> result;

  const MigrateMovieNowPlayingLoaded(this.result);

  @override
  List<Object> get props => [result];
}