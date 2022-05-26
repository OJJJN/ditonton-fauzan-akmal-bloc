part of 'migrate_movie_search_bloc.dart';

abstract class MigrateMovieSearchState extends Equatable {
  const MigrateMovieSearchState();

  @override
  List<Object> get props => [];
}

class MigrateMovieSearchEmpty extends MigrateMovieSearchState {}

class MigrateMovieSearchLoading extends MigrateMovieSearchState {}

class MigrateMovieSearchError extends MigrateMovieSearchState {
  final String message;

  const MigrateMovieSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieSearchLoaded extends MigrateMovieSearchState {
  final List<Movie> result;

  const MigrateMovieSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}