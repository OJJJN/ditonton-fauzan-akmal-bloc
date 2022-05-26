import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'migrate_movie_top_rated_event.dart';
part 'migrate_movie_top_rated_state.dart';

class MigrateMovieTopRatedBloc extends Bloc<MigrateMovieTopRatedEvent, MigrateMovieTopRatedState> {
  final GetTopRatedMovies getMigrateTopRatedMovies;

  MigrateMovieTopRatedBloc(
      this.getMigrateTopRatedMovies,
      ) : super(MigrateMovieTopRatedEmpty()) {
    on<MigrateMovieTopRatedGetEvent>((event, emit) async {
      emit(MigrateMovieTopRatedLoading());
      final result = await getMigrateTopRatedMovies.execute();
      result.fold(
            (failure) {
          emit(MigrateMovieTopRatedError(failure.message));
        },
            (data) {
          emit(MigrateMovieTopRatedLoaded(data));
        },
      );
    });
  }
}