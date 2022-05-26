import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_recommendation_movie/migrate_movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'migrate_movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([MigrateMovieRecommendationBloc, GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendation;
  late MigrateMovieRecommendationBloc migrateMovieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    migrateMovieRecommendationBloc = MigrateMovieRecommendationBloc(
      getMigrateMovieRecommendations: mockGetMovieRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(migrateMovieRecommendationBloc.state, MigrateMovieRecommendationEmpty());
  });

  const movieId = 1;
  final movieList = <Movie>[];

  blocTest<MigrateMovieRecommendationBloc, MigrateMovieRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(movieId))
          .thenAnswer((_) async => Right(movieList));
      return migrateMovieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMigrateMovieRecommendationEvent(movieId)),
    expect: () =>
    [MigrateMovieRecommendationLoading(), MigrateMovieRecommendationLoaded(movieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(movieId));
    },
  );

  group('Recommendation Movies BLoC Test', () {
    blocTest<MigrateMovieRecommendationBloc, MigrateMovieRecommendationState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetMovieRecommendation.execute(movieId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateMovieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const GetMigrateMovieRecommendationEvent(movieId)),
      expect: () => [
        MigrateMovieRecommendationLoading(),
        const MigrateMovieRecommendationError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendation.execute(movieId));
      },
    );
  },
  );
}