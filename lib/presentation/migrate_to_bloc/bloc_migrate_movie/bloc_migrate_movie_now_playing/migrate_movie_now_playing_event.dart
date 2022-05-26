part of 'migrate_movie_now_playing_bloc.dart';

abstract class MigrateMovieNowPlayingEvent extends Equatable {
  const MigrateMovieNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class MigrateMovieNowPlayingGetEvent extends MigrateMovieNowPlayingEvent {}