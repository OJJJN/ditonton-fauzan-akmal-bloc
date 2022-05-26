part of 'migrate_movie_top_rated_bloc.dart';

abstract class MigrateMovieTopRatedEvent extends Equatable {
  const MigrateMovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class MigrateMovieTopRatedGetEvent extends MigrateMovieTopRatedEvent {}