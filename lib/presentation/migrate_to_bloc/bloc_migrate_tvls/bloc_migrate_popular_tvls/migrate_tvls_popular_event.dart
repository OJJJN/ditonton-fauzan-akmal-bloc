part of 'migrate_tvls_popular_bloc.dart';

abstract class MigrateTvlsPopularEvent extends Equatable {
  const MigrateTvlsPopularEvent();

  @override
  List<Object> get props => [];
}

class MigrateTvlsPopularGetEvent extends MigrateTvlsPopularEvent {}