part of 'migrate_movie_search_bloc.dart';

abstract class MigrateMovieSearchEvent extends Equatable {
  const MigrateMovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MigrateMovieSearchSetEmpty extends MigrateMovieSearchEvent {}

class MigrateMovieSearchQueryEvent extends MigrateMovieSearchEvent {
  final String query;

  const MigrateMovieSearchQueryEvent(this.query);

  @override
  List<Object> get props => [];
}