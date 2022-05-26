import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:equatable/equatable.dart';

part 'migrate_tvls_on_air_event.dart';
part 'migrate_tvls_on_air_state.dart';

class MigrateTvlsOnAirBloc extends Bloc<MigrateTvlsOnAirEvent, MigrateTvlsOnAirState> {
  final GetNowPlayingTvls getMigrateOnAirTvls;

  MigrateTvlsOnAirBloc(
      this.getMigrateOnAirTvls,
      ) : super(MigrateTvlsOnAirEmpty()) {
    on<MigrateTvlsOnAirGetEvent>((event, emit) async {
      emit(MigrateTvlsOnAirLoading());
      final result = await getMigrateOnAirTvls.execute();
      result.fold(
            (failure) {
          emit(MigrateTvlsOnAirError(failure.message));
        },
            (data) {
          emit(MigrateTvlsOnAirLoaded(data));
        },
      );
    });
  }
}