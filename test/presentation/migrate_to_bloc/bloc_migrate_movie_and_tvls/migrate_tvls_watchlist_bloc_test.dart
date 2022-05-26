import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_watchlist_tvls/migrate_tvls_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import 'migrate_tvls_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  MigrateTvlsWatchlistBloc,
  GetWatchlistTvls,
  GetWatchListStatusTvls,
  RemoveWatchlistTvls,
  SaveWatchlistTvls])
void main() {
  late MockGetWatchlistTvls mockGetWatchlistTvls;
  late MockGetWatchListStatusTvls mockGetWatchListStatusTvls;
  late MockSaveWatchlistTvls mockSaveWatchlistTvls;
  late MockRemoveWatchlistTvls mockRemoveWatchlistTvls;
  late MigrateTvlsWatchlistBloc migrateTvlsWatchlistBloc;

  setUp(() {
    mockGetWatchlistTvls = MockGetWatchlistTvls();
    mockGetWatchListStatusTvls = MockGetWatchListStatusTvls();
    mockSaveWatchlistTvls = MockSaveWatchlistTvls();
    mockRemoveWatchlistTvls = MockRemoveWatchlistTvls();
    migrateTvlsWatchlistBloc = MigrateTvlsWatchlistBloc(
      getWatchlistTv: mockGetWatchlistTvls,
      getWatchListStatus: mockGetWatchListStatusTvls,
      saveWatchlist: mockSaveWatchlistTvls,
      removeWatchlist: mockRemoveWatchlistTvls,
    );
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(migrateTvlsWatchlistBloc.state, MigrateTvlsWatchlistEmpty());
  });

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvls.execute())
          .thenAnswer((_) async => Right(testWatchlistTvList));
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(MigrateTvlsGetListEvent()),
    expect: () =>
    [MigrateTvlsWatchlistLoading(), MigrateTvlsWatchlistLoaded(testWatchlistTvList)],
    verify: (bloc) {
      verify(mockGetWatchlistTvls.execute());
    },
  );

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvls.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(MigrateTvlsGetListEvent()),
    expect: () =>
    [MigrateTvlsWatchlistLoading(), const MigrateTvlsWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistTvls.execute());
    },
  );

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [Loaded] when get status tv watchlist is successful',
    build: () {
      when(mockGetWatchListStatusTvls.execute(tvId))
          .thenAnswer((_) async => true);
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(const MigrateGetStatusTvlsEvent(tvId)),
    expect: () => [const MigrateTvlsWatchlistStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatusTvls.execute(tvId));
    },
  );

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [success] when add tv item to watchlist is successful',
    build: () {
      when(mockSaveWatchlistTvls.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Success"));
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(MigrateAddItemTvlsEvent(testTvDetail)),
    expect: () => [const MigrateTvlsWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlistTvls.execute(testTvDetail));
    },
  );

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [success] when remove tv item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTvls.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(MigrateRemoveItemTvlsEvent(testTvDetail)),
    expect: () => [const MigrateTvlsWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvls.execute(testTvDetail));
    },
  );

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [error] when add tv item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTvls.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(MigrateAddItemTvlsEvent(testTvDetail)),
    expect: () => [const MigrateTvlsWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlistTvls.execute(testTvDetail));
    },
  );

  blocTest<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
    'Should emit [error] when remove tv item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTvls.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return migrateTvlsWatchlistBloc;
    },
    act: (bloc) => bloc.add(MigrateRemoveItemTvlsEvent(testTvDetail)),
    expect: () => [const MigrateTvlsWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvls.execute(testTvDetail));
    },
  );
}