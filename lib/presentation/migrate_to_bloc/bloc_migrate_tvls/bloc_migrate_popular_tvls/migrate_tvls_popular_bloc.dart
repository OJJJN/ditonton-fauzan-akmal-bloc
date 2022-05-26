import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:equatable/equatable.dart';

part 'migrate_tvls_popular_event.dart';
part 'migrate_tvls_popular_state.dart';

class MigrateTvlsPopularBloc extends Bloc<MigrateTvlsPopularEvent, MigrateTvlsPopularState> {
  final GetPopularTvls getMigratePopularTvls;

  MigrateTvlsPopularBloc(
      this.getMigratePopularTvls,
      ) : super(MigrateTvlsPopularEmpty()) {
    on<MigrateTvlsPopularGetEvent>((event, emit) async {
      emit(MigrateTvlsPopularLoading());
      final result = await getMigratePopularTvls.execute();
      result.fold(
            (failure) {
          emit(MigrateTvlsPopularError(failure.message));
        },
            (data) {
          emit(MigrateTvlsPopularLoaded(data));
        },
      );
    });
  }
}