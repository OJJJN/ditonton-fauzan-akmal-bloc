part of 'migrate_tvls_search_bloc.dart';

abstract class MigrateTvlsSearchEvent extends Equatable {
  const MigrateTvlsSearchEvent();

  @override
  List<Object> get props => [];
}

class MigrateTvlsSearchSetEmpty extends MigrateTvlsSearchEvent {}

class MigrateTvlsSearchQueryEvent extends MigrateTvlsSearchEvent {
  final String query;

  const MigrateTvlsSearchQueryEvent(this.query);

  @override
  List<Object> get props => [];
}