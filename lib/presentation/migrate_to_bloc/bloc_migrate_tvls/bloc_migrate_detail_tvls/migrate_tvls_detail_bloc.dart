import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:equatable/equatable.dart';

part 'migrate_tvls_detail_event.dart';
part 'migrate_tvls_detail_state.dart';

class MigrateTvlsDetailBloc extends Bloc<MigrateTvlsDetailEvent, MigrateTvlsDetailState> {
  final GetTvlsDetail getMigrateTvlsDetail;

  MigrateTvlsDetailBloc({
    required this.getMigrateTvlsDetail,
  }) : super(MigrateTvlsDetailEmpty()) {
    on<GetMigrateTvlsDetailEvent>((event, emit) async {
      emit(MigrateTvlsDetailLoading());
      final result = await getMigrateTvlsDetail.execute(event.id);
      result.fold(
            (failure) {
          emit(MigrateTvlsDetailError(failure.message));
        },
            (data) {
          emit(MigrateTvlsDetailLoaded(data));
        },
      );
    });
  }
}