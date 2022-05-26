part of 'migrate_movie_detail_bloc.dart';

abstract class MigrateMovieDetailState extends Equatable {
  const MigrateMovieDetailState();

  @override
  List<Object> get props => [];
}

class MigrateMovieDetailEmpty extends MigrateMovieDetailState {}

class MigrateMovieDetailLoading extends MigrateMovieDetailState {}

class MigrateMovieDetailError extends MigrateMovieDetailState {
  final String message;

  const MigrateMovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieDetailLoaded extends MigrateMovieDetailState {
  final MovieDetail result;

  const MigrateMovieDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}