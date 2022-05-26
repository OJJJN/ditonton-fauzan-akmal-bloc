import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_popular_movie/migrate_movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'migrate_movie_popular_bloc_test.mocks.dart';

@GenerateMocks([MigrateMoviePopularBloc, GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MigrateMoviePopularBloc migrateMoviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    migrateMoviePopularBloc = MigrateMoviePopularBloc(mockGetPopularMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(migrateMoviePopularBloc.state, MigrateMoviePopularEmpty());
  });

  group('Popular Movies BLoC Test', () {
    blocTest<MigrateMoviePopularBloc, MigrateMoviePopularState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return migrateMoviePopularBloc;
        },
        act: (bloc) => bloc.add(MigrateMoviePopularGetEvent()),
        expect: () =>
        [MigrateMoviePopularLoading(), MigrateMoviePopularLoaded(movieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<MigrateMoviePopularBloc, MigrateMoviePopularState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return migrateMoviePopularBloc;
        },
        act: (bloc) => bloc.add(MigrateMoviePopularGetEvent()),
        expect: () =>
        [MigrateMoviePopularLoading(), MigrateMoviePopularError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
