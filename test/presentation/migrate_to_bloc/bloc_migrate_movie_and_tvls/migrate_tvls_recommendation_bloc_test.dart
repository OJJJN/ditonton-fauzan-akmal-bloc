import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_recommendation_tvls/migrate_tvls_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'migrate_tvls_recommendation_bloc_test.mocks.dart';

@GenerateMocks([MigrateTvlsRecommendationBloc, GetTvlsRecommendations])
void main() {
  late MockGetTvlsRecommendations mockGetTvlsRecommendation;
  late MigrateTvlsRecommendationBloc migrateTvlsRecommendationBloc;

  setUp(() {
    mockGetTvlsRecommendation = MockGetTvlsRecommendations();
    migrateTvlsRecommendationBloc = MigrateTvlsRecommendationBloc(
      getTvlsRecommendations: mockGetTvlsRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(migrateTvlsRecommendationBloc.state, MigrateTvlsRecommendationEmpty());
  });

  const tvId = 1;
  final tvList = <Tvls>[];

  blocTest<MigrateTvlsRecommendationBloc, TvlsRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvlsRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tvList));
      return migrateTvlsRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMigrateTvlsRecommendationEvent(tvId)),
    expect: () =>
    [MigrateTvlsRecommendationLoading(), TvlsRecommendationLoaded(tvList)],
    verify: (bloc) {
      verify(mockGetTvlsRecommendation.execute(tvId));
    },
  );

  group('Recommendation Tv BLoC Test', () {
    blocTest<MigrateTvlsRecommendationBloc, TvlsRecommendationState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetTvlsRecommendation.execute(tvId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateTvlsRecommendationBloc;
      },
      act: (bloc) => bloc.add(const GetMigrateTvlsRecommendationEvent(tvId)),
      expect: () => [
        MigrateTvlsRecommendationLoading(),
        const MigrateTvlsRecommendationError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTvlsRecommendation.execute(tvId));
      },
    );
  },
  );
}