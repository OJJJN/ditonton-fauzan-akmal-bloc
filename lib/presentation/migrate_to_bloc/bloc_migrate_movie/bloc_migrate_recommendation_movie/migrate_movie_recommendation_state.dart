part of 'migrate_movie_recommendation_bloc.dart';

abstract class MigrateMovieRecommendationState extends Equatable {
  const MigrateMovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MigrateMovieRecommendationEmpty extends MigrateMovieRecommendationState {}

class MigrateMovieRecommendationLoading extends MigrateMovieRecommendationState {}

class MigrateMovieRecommendationError extends MigrateMovieRecommendationState {
  final String message;

  const MigrateMovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MigrateMovieRecommendationLoaded extends MigrateMovieRecommendationState {
  final List<Movie> movie;

  const MigrateMovieRecommendationLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}