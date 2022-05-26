part of 'migrate_tvls_on_air_bloc.dart';

abstract class MigrateTvlsOnAirEvent extends Equatable {
  const MigrateTvlsOnAirEvent();

  @override
  List<Object> get props => [];
}

class MigrateTvlsOnAirGetEvent extends MigrateTvlsOnAirEvent {}