part of 'migrate_tvls_popular_bloc.dart';

abstract class MigrateTvlsPopularState extends Equatable {
  const MigrateTvlsPopularState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsPopularEmpty extends MigrateTvlsPopularState {}

class MigrateTvlsPopularLoading extends MigrateTvlsPopularState {}

class MigrateTvlsPopularError extends MigrateTvlsPopularState {
  final String message;

  const MigrateTvlsPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsPopularLoaded extends MigrateTvlsPopularState {
  final List<Tvls> result;

  const MigrateTvlsPopularLoaded(this.result);

  @override
  List<Object> get props => [result];
}