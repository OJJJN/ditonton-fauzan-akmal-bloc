import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_top_rated_tvls/migrate_tvls_top_rated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'migrate_tvls_top_rated_bloc_test.mocks.dart';

@GenerateMocks([MigrateTvlsTopRatedBloc, GetTopRatedTvls])
void main() {
  late MockGetTopRatedTvls mockGetTopRatedTvls;
  late MigrateTvlsTopRatedBloc migrateTvlsTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvls = MockGetTopRatedTvls();
    migrateTvlsTopRatedBloc = MigrateTvlsTopRatedBloc(mockGetTopRatedTvls);
  });

  final tvList = <Tvls>[];

  test("initial state should be empty", () {
    expect(migrateTvlsTopRatedBloc.state, MigrateTvlsTopRatedEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<MigrateTvlsTopRatedBloc, MigrateTvlsTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvls.execute())
            .thenAnswer((_) async => Right(tvList));
        return migrateTvlsTopRatedBloc;
      },
      act: (bloc) => bloc.add(MigrateTvlsTopRatedGetEvent()),
      expect: () => [MigrateTvlsTopRatedLoading(), MigrateTvlsTopRatedLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetTopRatedTvls.execute());
      },
    );

    blocTest<MigrateTvlsTopRatedBloc, MigrateTvlsTopRatedState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedTvls.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateTvlsTopRatedBloc;
      },
      act: (bloc) => bloc.add(MigrateTvlsTopRatedGetEvent()),
      expect: () =>
      [MigrateTvlsTopRatedLoading(), const MigrateTvlsTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedTvls.execute());
      },
    );
  },);
}