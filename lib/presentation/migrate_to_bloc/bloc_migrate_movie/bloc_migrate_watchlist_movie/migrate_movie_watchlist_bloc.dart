import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'migrate_movie_watchlist_event.dart';
part 'migrate_movie_watchlist_state.dart';

class MigrateMovieWatchlistBloc extends Bloc<MigrateMovieWatchlistEvent, MigrateMovieWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MigrateMovieWatchlistBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MigrateMovieWatchlistEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(MigrateMovieWatchlistLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
            (failure) {
          emit(MigrateMovieWatchlistError(failure.message));
        },
            (data) {
          emit(MigrateMovieWatchlistLoaded(data));
        },
      );
    });

    on<GetStatusMovieEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);

      emit(MigrateMovieWatchlistStatusLoaded(result));
    });

    on<AddItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await saveWatchlist.execute(movieDetail);
      result.fold(
            (failure) {
          emit(MigrateMovieWatchlistError(failure.message));
        },
            (successMessage) {
          emit(MigrateMovieWatchlistSuccess(successMessage));
        },
      );
    });

    on<RemoveItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);

      result.fold(
            (failure) {
          emit(MigrateMovieWatchlistError(failure.message));
        },
            (successMessage) {
          emit(MigrateMovieWatchlistSuccess(successMessage));
        },
      );
    });
  }
}