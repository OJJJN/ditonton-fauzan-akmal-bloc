part of 'migrate_movie_detail_bloc.dart';

abstract class MigrateMovieDetailEvent extends Equatable {
  const MigrateMovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMigrateMovieDetailEvent extends MigrateMovieDetailEvent {
  final int id;

  const GetMigrateMovieDetailEvent(this.id);

  @override
  List<Object> get props => [];
}