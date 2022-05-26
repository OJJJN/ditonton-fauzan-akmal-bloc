part of 'migrate_tvls_recommendation_bloc.dart';

abstract class TvlsRecommendationState extends Equatable {
  const TvlsRecommendationState();

  @override
  List<Object> get props => [];
}

class MigrateTvlsRecommendationEmpty extends TvlsRecommendationState {}

class MigrateTvlsRecommendationLoading extends TvlsRecommendationState {}

class MigrateTvlsRecommendationError extends TvlsRecommendationState {
  final String message;

  const MigrateTvlsRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvlsRecommendationLoaded extends TvlsRecommendationState {
  final List<Tvls> tv;

  const TvlsRecommendationLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}