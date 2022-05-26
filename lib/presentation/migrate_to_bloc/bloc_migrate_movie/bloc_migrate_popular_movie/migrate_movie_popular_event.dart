part of 'migrate_movie_popular_bloc.dart';

abstract class MigrateMoviePopularEvent extends Equatable {
  const MigrateMoviePopularEvent();

  @override
  List<Object> get props => [];
}

class MigrateMoviePopularGetEvent extends MigrateMoviePopularEvent {}