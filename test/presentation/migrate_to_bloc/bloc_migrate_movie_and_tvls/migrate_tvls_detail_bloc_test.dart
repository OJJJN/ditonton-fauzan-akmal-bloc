import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_detail_tvls/migrate_tvls_detail_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import 'migrate_tvls_detail_bloc_test.mocks.dart';

@GenerateMocks([MigrateTvlsDetailBloc, GetTvlsDetail])
void main() {
  late MockGetTvlsDetail mockGetTvlsDetail;
  late MigrateTvlsDetailBloc migrateTvlsDetailBloc;
  setUp(() {
    mockGetTvlsDetail = MockGetTvlsDetail();
    migrateTvlsDetailBloc = MigrateTvlsDetailBloc(getMigrateTvlsDetail: mockGetTvlsDetail);
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(migrateTvlsDetailBloc.state, MigrateTvlsDetailEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<MigrateTvlsDetailBloc, MigrateTvlsDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvlsDetail.execute(tvId))
            .thenAnswer((_) async => Right(testTvDetail));
        return migrateTvlsDetailBloc;
      },
      act: (bloc) => bloc.add(const GetMigrateTvlsDetailEvent(tvId)),
      expect: () => [MigrateTvlsDetailLoading(), MigrateTvlsDetailLoaded(testTvDetail)],
      verify: (bloc) {
        verify(mockGetTvlsDetail.execute(tvId));
      },
    );

    blocTest<MigrateTvlsDetailBloc, MigrateTvlsDetailState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetTvlsDetail.execute(tvId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateTvlsDetailBloc;
      },
      act: (bloc) => bloc.add(const GetMigrateTvlsDetailEvent(tvId)),
      expect: () => [MigrateTvlsDetailLoading(), const MigrateTvlsDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvlsDetail.execute(tvId));
      },
    );
  },);
}