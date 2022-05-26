import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'migrate_movie_recommendation_event.dart';
part 'migrate_movie_recommendation_state.dart';

class MigrateMovieRecommendationBloc
    extends Bloc<MigrateMovieRecommendationEvent, MigrateMovieRecommendationState> {
  final GetMovieRecommendations getMigrateMovieRecommendations;

  MigrateMovieRecommendationBloc({
    required this.getMigrateMovieRecommendations,
  }) : super(MigrateMovieRecommendationEmpty()){
    on<GetMigrateMovieRecommendationEvent>((event, emit) async {
      emit(MigrateMovieRecommendationLoading());
      final result = await getMigrateMovieRecommendations.execute(event.id);
      result.fold(
            (failure) {
          emit(MigrateMovieRecommendationError(failure.message));
        },
            (data) {
          emit(MigrateMovieRecommendationLoaded(data));
        },
      );
    });
  }
}