part of 'migrate_tvls_detail_bloc.dart';

abstract class MigrateTvlsDetailEvent extends Equatable {
  const MigrateTvlsDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMigrateTvlsDetailEvent extends MigrateTvlsDetailEvent {
  final int id;

  const GetMigrateTvlsDetailEvent(this.id);

  @override
  List<Object> get props => [];
}