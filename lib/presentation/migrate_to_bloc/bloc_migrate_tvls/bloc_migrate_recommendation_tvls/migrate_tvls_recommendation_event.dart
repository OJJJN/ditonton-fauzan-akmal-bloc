part of 'migrate_tvls_recommendation_bloc.dart';

abstract class MigrateTvlsRecommendationEvent extends Equatable {
  const MigrateTvlsRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetMigrateTvlsRecommendationEvent extends MigrateTvlsRecommendationEvent {
  final int id;

  const GetMigrateTvlsRecommendationEvent(this.id);

  @override
  List<Object> get props => [];
}