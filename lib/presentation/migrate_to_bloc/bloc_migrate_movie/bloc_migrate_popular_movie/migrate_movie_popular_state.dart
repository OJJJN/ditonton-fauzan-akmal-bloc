part of 'migrate_movie_popular_bloc.dart';

abstract class MigrateMoviePopularState extends Equatable {
  const MigrateMoviePopularState();

  @override
  List<Object> get props => [];
}

class MigrateMoviePopularEmpty extends MigrateMoviePopularState {}

class MigrateMoviePopularLoading extends MigrateMoviePopularState {}

class MigrateMoviePopularError extends MigrateMoviePopularState {
  final String message;

  const MigrateMoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMoviePopularLoaded extends MigrateMoviePopularState {
  final List<Movie> result;

  const MigrateMoviePopularLoaded(this.result);

  @override
  List<Object> get props => [result];
}