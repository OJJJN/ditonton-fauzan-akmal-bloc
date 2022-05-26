part of 'migrate_tvls_top_rated_bloc.dart';

abstract class MigrateTvlsTopRatedEvent extends Equatable {
  const MigrateTvlsTopRatedEvent();

  @override
  List<Object> get props => [];
}

class MigrateTvlsTopRatedGetEvent extends MigrateTvlsTopRatedEvent {}