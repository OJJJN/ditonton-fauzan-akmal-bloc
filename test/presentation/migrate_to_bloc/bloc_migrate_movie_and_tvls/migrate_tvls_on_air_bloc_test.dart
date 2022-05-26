import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_on_air_tvls/migrate_tvls_on_air_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'migrate_tvls_on_air_bloc_test.mocks.dart';

@GenerateMocks([MigrateTvlsOnAirBloc, GetNowPlayingTvls])
void main() {
  late MockGetNowPlayingTvls mockGetNowPlayingTvls;
  late MigrateTvlsOnAirBloc migrateTvlsOnAirBloc;

  setUp(() {
    mockGetNowPlayingTvls = MockGetNowPlayingTvls();
    migrateTvlsOnAirBloc = MigrateTvlsOnAirBloc(mockGetNowPlayingTvls);
  });

  final tvList = <Tvls>[];

  test("initial state should be empty", () {
    expect(migrateTvlsOnAirBloc.state, MigrateTvlsOnAirEmpty());
  });

  group('On Air Tv BLoC Test', () {
    blocTest<MigrateTvlsOnAirBloc, MigrateTvlsOnAirState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvls.execute())
            .thenAnswer((_) async => Right(tvList));
        return migrateTvlsOnAirBloc;
      },
      act: (bloc) => bloc.add(MigrateTvlsOnAirGetEvent()),
      expect: () => [MigrateTvlsOnAirLoading(), MigrateTvlsOnAirLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTvls.execute());
      },
    );

    blocTest<MigrateTvlsOnAirBloc, MigrateTvlsOnAirState>(
      'Should emit [Loading, Error] when get now playing is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvls.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateTvlsOnAirBloc;
      },
      act: (bloc) => bloc.add(MigrateTvlsOnAirGetEvent()),
      expect: () => [
        MigrateTvlsOnAirLoading(),
        const MigrateTvlsOnAirError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvls.execute());
      },
    );
  },
  );
}