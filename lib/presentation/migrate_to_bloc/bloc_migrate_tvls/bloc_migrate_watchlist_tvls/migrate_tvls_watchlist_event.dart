part of 'migrate_tvls_watchlist_bloc.dart';

abstract class MigrateTvlsWatchlistEvent extends Equatable {
  const MigrateTvlsWatchlistEvent();

  @override
  List<Object> get props => [];
}

class MigrateTvlsGetListEvent extends MigrateTvlsWatchlistEvent {}

class MigrateGetStatusTvlsEvent extends MigrateTvlsWatchlistEvent {
  final int id;

  const MigrateGetStatusTvlsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class MigrateAddItemTvlsEvent extends MigrateTvlsWatchlistEvent {
  final TvlsDetail tvDetail;

  const MigrateAddItemTvlsEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class MigrateRemoveItemTvlsEvent extends MigrateTvlsWatchlistEvent {
  final TvlsDetail tvDetail;

  const MigrateRemoveItemTvlsEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}