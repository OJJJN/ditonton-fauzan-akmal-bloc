import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_popular_tvls/migrate_tvls_popular_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'migrate_tvls_popular_bloc_test.mocks.dart';

@GenerateMocks([MigrateTvlsPopularBloc, GetPopularTvls])
void main() {
  late MockGetPopularTvls mockGetPopularTvls;
  late MigrateTvlsPopularBloc migrateTvlsPopularBloc;

  setUp(() {
    mockGetPopularTvls = MockGetPopularTvls();
    migrateTvlsPopularBloc = MigrateTvlsPopularBloc(mockGetPopularTvls);
  });

  final TvList = <Tvls>[];

  test("initial state should be empty", () {
    expect(migrateTvlsPopularBloc.state, MigrateTvlsPopularEmpty());
  });

  group('Popular Tv BLoC Test', () {
    blocTest<MigrateTvlsPopularBloc, MigrateTvlsPopularState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvls.execute()).thenAnswer((_) async => Right(TvList));
        return migrateTvlsPopularBloc;
      },
      act: (bloc) => bloc.add(MigrateTvlsPopularGetEvent()),
      expect: () => [MigrateTvlsPopularLoading(), MigrateTvlsPopularLoaded(TvList)],
      verify: (bloc) {
        verify(mockGetPopularTvls.execute());
      },
    );

    blocTest<MigrateTvlsPopularBloc, MigrateTvlsPopularState>(
      'Should emit [Loading, Error] when get popular is unsuccessful',
      build: () {
        when(mockGetPopularTvls.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateTvlsPopularBloc;
      },
      act: (bloc) => bloc.add(MigrateTvlsPopularGetEvent()),
      expect: () => [MigrateTvlsPopularLoading(),  MigrateTvlsPopularError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularTvls.execute());
      },
    );
  },);
}