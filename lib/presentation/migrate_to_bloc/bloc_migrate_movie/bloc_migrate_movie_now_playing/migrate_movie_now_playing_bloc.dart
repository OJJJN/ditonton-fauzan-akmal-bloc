import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'migrate_movie_now_playing_event.dart';
part 'migrate_movie_now_playing_state.dart';

class MigrateMovieNowPlayingBloc
    extends Bloc<MigrateMovieNowPlayingEvent, MigrateMovieNowPlayingState> {
  final GetNowPlayingMovies getMigrateNowPlayingMovies;

  MigrateMovieNowPlayingBloc(
      this.getMigrateNowPlayingMovies,
      ) : super(MigrateMovieNowPlayingEmpty()) {
    on<MigrateMovieNowPlayingGetEvent>((event, emit) async {
      emit(MigrateMovieNowPlayingLoading());
      final result = await getMigrateNowPlayingMovies.execute();
      result.fold(
            (failure) {
          emit(MigrateMovieNowPlayingError(failure.message));
        },
            (data) {
          emit(MigrateMovieNowPlayingLoaded(data));
        },
      );
    });
  }
}