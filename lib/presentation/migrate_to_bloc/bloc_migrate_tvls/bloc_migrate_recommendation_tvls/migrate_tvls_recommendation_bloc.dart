import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:equatable/equatable.dart';

part 'migrate_tvls_recommendation_event.dart';
part 'migrate_tvls_recommendation_state.dart';

class MigrateTvlsRecommendationBloc
    extends Bloc<MigrateTvlsRecommendationEvent, TvlsRecommendationState> {
  final GetTvlsRecommendations getTvlsRecommendations;

  MigrateTvlsRecommendationBloc({
    required this.getTvlsRecommendations,
  }) : super(MigrateTvlsRecommendationEmpty()) {
    on<GetMigrateTvlsRecommendationEvent>((event, emit) async {
      emit(MigrateTvlsRecommendationLoading());
      final result = await getTvlsRecommendations.execute(event.id);
      result.fold(
            (failure) {
          emit(MigrateTvlsRecommendationError(failure.message));
        },
            (data) {
          emit(TvlsRecommendationLoaded(data));
        },
      );
    });
  }
}