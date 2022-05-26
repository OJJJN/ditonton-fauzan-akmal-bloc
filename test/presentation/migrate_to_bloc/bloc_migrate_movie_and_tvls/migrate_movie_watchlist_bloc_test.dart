import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_watchlist_movie/migrate_movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'migrate_movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  MigrateMovieWatchlistBloc,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MigrateMovieWatchlistBloc migrateMovieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    migrateMovieWatchlistBloc = MigrateMovieWatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const movieId = 1;

  test("initial state should be empty", () {
    expect(migrateMovieWatchlistBloc.state, MigrateMovieWatchlistEmpty());
  });

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testWatchlistMovieList));
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
    [MigrateMovieWatchlistLoading(), MigrateMovieWatchlistLoaded(testWatchlistMovieList)],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
    [MigrateMovieWatchlistLoading(), const MigrateMovieWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [Loaded] when get status movie watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(movieId))
          .thenAnswer((_) async => true);
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusMovieEvent(movieId)),
    expect: () => [const MigrateMovieWatchlistStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(movieId));
    },
  );

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [success] when add movie item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Success"));
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: () => [const MigrateMovieWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [success] when remove movie item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: () => [const MigrateMovieWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [error] when add movie item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: () => [const MigrateMovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MigrateMovieWatchlistBloc, MigrateMovieWatchlistState>(
    'Should emit [error] when remove movie item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: () => [const MigrateMovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}