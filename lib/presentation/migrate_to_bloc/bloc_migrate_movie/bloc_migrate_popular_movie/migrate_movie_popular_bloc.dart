import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'migrate_movie_popular_event.dart';
part 'migrate_movie_popular_state.dart';

class MigrateMoviePopularBloc extends Bloc<MigrateMoviePopularEvent, MigrateMoviePopularState> {
  final GetPopularMovies getMigratePopularMovies;

  MigrateMoviePopularBloc(
      this.getMigratePopularMovies,
      ) : super(MigrateMoviePopularEmpty()) {
    on<MigrateMoviePopularGetEvent>((event, emit) async {
      emit(MigrateMoviePopularLoading());
      final result = await getMigratePopularMovies.execute();
      result.fold(
            (failure) {
          emit(MigrateMoviePopularError(failure.message));
        },
            (data) {
          emit(MigrateMoviePopularLoaded(data));
        },
      );
    });
  }
}