import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_detail_movie/migrate_movie_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'migrate_movie_detail_bloc_test.mocks.dart';

@GenerateMocks([MigrateMovieDetailBloc, GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MigrateMovieDetailBloc migrateMovieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    migrateMovieDetailBloc = MigrateMovieDetailBloc(getMigrateMovieDetail: mockGetMovieDetail);
  });

  const movieId = 1;

  test("initial state should be empty", () {
    expect(migrateMovieDetailBloc.state, MigrateMovieDetailEmpty());
  });

  group('Detail Movies BLoC Test', () {
    blocTest<MigrateMovieDetailBloc, MigrateMovieDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(movieId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return migrateMovieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetMigrateMovieDetailEvent(movieId)),
      expect: () =>
      [MigrateMovieDetailLoading(), MigrateMovieDetailLoaded(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(movieId));
      },
    );

    blocTest<MigrateMovieDetailBloc, MigrateMovieDetailState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(movieId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateMovieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetMigrateMovieDetailEvent(movieId)),
      expect: () =>
      [MigrateMovieDetailLoading(), const MigrateMovieDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(movieId));
      },
    );
  });
}
