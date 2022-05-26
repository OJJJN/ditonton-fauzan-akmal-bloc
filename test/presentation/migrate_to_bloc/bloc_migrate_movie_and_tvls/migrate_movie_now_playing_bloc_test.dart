import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_movie_now_playing/migrate_movie_now_playing_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'migrate_movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([MigrateMovieNowPlayingBloc, GetNowPlayingMovies])

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MigrateMovieNowPlayingBloc migrateMovieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    migrateMovieNowPlayingBloc = MigrateMovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(migrateMovieNowPlayingBloc.state, MigrateMovieNowPlayingEmpty());
  });

  blocTest<MigrateMovieNowPlayingBloc, MigrateMovieNowPlayingState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return migrateMovieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MigrateMovieNowPlayingGetEvent()),
    expect: () => [
      MigrateMovieNowPlayingLoading(),
      MigrateMovieNowPlayingLoaded(testMovieList)
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MigrateMovieNowPlayingBloc, MigrateMovieNowPlayingState>(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return migrateMovieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MigrateMovieNowPlayingGetEvent()),
    expect: () => [
      MigrateMovieNowPlayingLoading(),
      MigrateMovieNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}