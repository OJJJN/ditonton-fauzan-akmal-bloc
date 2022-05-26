part of 'migrate_movie_recommendation_bloc.dart';

abstract class MigrateMovieRecommendationEvent extends Equatable {
  const MigrateMovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetMigrateMovieRecommendationEvent extends MigrateMovieRecommendationEvent {
  final int id;

  const GetMigrateMovieRecommendationEvent(this.id);

  @override
  List<Object> get props => [];
}