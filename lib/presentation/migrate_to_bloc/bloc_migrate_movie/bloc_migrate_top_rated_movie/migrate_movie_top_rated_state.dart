part of 'migrate_movie_top_rated_bloc.dart';

abstract class MigrateMovieTopRatedState extends Equatable {
  const MigrateMovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MigrateMovieTopRatedEmpty extends MigrateMovieTopRatedState {}

class MigrateMovieTopRatedLoading extends MigrateMovieTopRatedState {}

class MigrateMovieTopRatedError extends MigrateMovieTopRatedState {
  final String message;

  const MigrateMovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieTopRatedLoaded extends MigrateMovieTopRatedState {
  final List<Movie> result;

  const MigrateMovieTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}