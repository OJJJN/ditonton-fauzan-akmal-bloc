part of 'migrate_tvls_detail_bloc.dart';

abstract class MigrateTvlsDetailState extends Equatable {
  const MigrateTvlsDetailState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsDetailEmpty extends MigrateTvlsDetailState {}

class MigrateTvlsDetailLoading extends MigrateTvlsDetailState {}

class MigrateTvlsDetailError extends MigrateTvlsDetailState {
  final String message;

  const MigrateTvlsDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateTvlsDetailLoaded extends MigrateTvlsDetailState {
  final TvlsDetail result;

  const MigrateTvlsDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}