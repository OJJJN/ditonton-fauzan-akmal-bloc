import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:equatable/equatable.dart';

part 'migrate_tvls_top_rated_event.dart';
part 'migrate_tvls_top_rated_state.dart';

class MigrateTvlsTopRatedBloc extends Bloc<MigrateTvlsTopRatedEvent, MigrateTvlsTopRatedState> {
  final GetTopRatedTvls getMigrateTopRatedTvls;

  MigrateTvlsTopRatedBloc(
      this.getMigrateTopRatedTvls,
      ) : super(MigrateTvlsTopRatedEmpty()) {
    on<MigrateTvlsTopRatedGetEvent>((event, emit) async {
      emit(MigrateTvlsTopRatedLoading());
      final result = await getMigrateTopRatedTvls.execute();
      result.fold(
            (failure) {
          emit(MigrateTvlsTopRatedError(failure.message));
        },
            (data) {
          emit(MigrateTvlsTopRatedLoaded(data));
        },
      );
    });
  }
}