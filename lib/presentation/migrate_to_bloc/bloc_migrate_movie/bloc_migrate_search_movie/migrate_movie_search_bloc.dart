import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'migrate_movie_search_event.dart';
part 'migrate_movie_search_state.dart';

class MigrateMovieSearchBloc extends Bloc<MigrateMovieSearchEvent, MigrateMovieSearchState> {
  final SearchMovies searchMovies;

  MigrateMovieSearchBloc({
    required this.searchMovies,
  }) : super(MigrateMovieSearchEmpty()) {
    on<MigrateMovieSearchSetEmpty>((event, emit) => emit(MigrateMovieSearchEmpty()));
    on<MigrateMovieSearchQueryEvent>((event, emit) async {
      emit(MigrateMovieSearchLoading());
      final result = await searchMovies.execute(event.query);
      result.fold(
            (failure) {
          emit(MigrateMovieSearchError(failure.message));
        },
            (data) {
          emit(MigrateMovieSearchLoaded(data));
        },
      );
    });
  }
}