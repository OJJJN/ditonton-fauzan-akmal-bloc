part of 'migrate_tvls_on_air_bloc.dart';

abstract class MigrateTvlsOnAirState extends Equatable {
  const MigrateTvlsOnAirState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsOnAirEmpty extends MigrateTvlsOnAirState {}

class MigrateTvlsOnAirLoading extends MigrateTvlsOnAirState {}

class MigrateTvlsOnAirError extends MigrateTvlsOnAirState {
  final String message;

  const MigrateTvlsOnAirError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsOnAirLoaded extends MigrateTvlsOnAirState {
  final List<Tvls> result;

  const MigrateTvlsOnAirLoaded(this.result);

  @override
  List<Object> get props => [result];
}