import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/search_tvls.dart';
import 'package:equatable/equatable.dart';


part 'migrate_tvls_search_event.dart';
part 'migrate_tvls_search_state.dart';

class MigrateTvlsSearchBloc extends Bloc<MigrateTvlsSearchEvent, MigrateTvlsSearchState> {
  final SearchTvls searchMigrateTvls;

  MigrateTvlsSearchBloc({
    required this.searchMigrateTvls,
  }) : super(MigrateTvlsSearchEmpty()) {
    on<MigrateTvlsSearchSetEmpty>((event, emit) => emit(MigrateTvlsSearchEmpty()));

    on<MigrateTvlsSearchQueryEvent>((event, emit) async {
      emit(MigrateTvlsSearchLoading());
      final result = await searchMigrateTvls.execute(event.query);
      result.fold(
            (failure) {
          emit(MigrateTvlsSearchError(failure.message));
        },
            (data) {
          emit(MigrateTvlsSearchLoaded(data));
        },
      );
    });
  }
}