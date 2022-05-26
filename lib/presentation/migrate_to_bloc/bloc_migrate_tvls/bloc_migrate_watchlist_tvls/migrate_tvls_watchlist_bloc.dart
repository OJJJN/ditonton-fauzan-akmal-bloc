import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'migrate_tvls_watchlist_event.dart';
part 'migrate_tvls_watchlist_state.dart';

class MigrateTvlsWatchlistBloc extends Bloc<MigrateTvlsWatchlistEvent, MigrateTvlsWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTvls getWatchlistTv;
  final GetWatchListStatusTvls getWatchListStatus;
  final SaveWatchlistTvls saveWatchlist;
  final RemoveWatchlistTvls removeWatchlist;

  MigrateTvlsWatchlistBloc({
    required this.getWatchlistTv,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MigrateTvlsWatchlistEmpty()) {
    on<MigrateTvlsGetListEvent>((event, emit) async {
      emit(MigrateTvlsWatchlistLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
            (failure) {
          emit(MigrateTvlsWatchlistError(failure.message));
        },
            (data) {
          emit(MigrateTvlsWatchlistLoaded(data));
        },
      );
    });

    on<MigrateGetStatusTvlsEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(MigrateTvlsWatchlistStatusLoaded(result));
    });

    on<MigrateAddItemTvlsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await saveWatchlist.execute(tvDetail);

      result.fold(
            (failure) {
          emit(MigrateTvlsWatchlistError(failure.message));
        },
            (successMessage) {
          emit(MigrateTvlsWatchlistSuccess(successMessage));
        },
      );
    });

    on<MigrateRemoveItemTvlsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await removeWatchlist.execute(tvDetail);

      result.fold(
            (failure) {
          emit(MigrateTvlsWatchlistError(failure.message));
        },
            (successMessage) {
          emit(MigrateTvlsWatchlistSuccess(successMessage));
        },
      );
    });
  }
}