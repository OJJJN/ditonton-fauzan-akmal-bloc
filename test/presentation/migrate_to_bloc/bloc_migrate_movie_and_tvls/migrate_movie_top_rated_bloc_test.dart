import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_top_rated_movie/migrate_movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'migrate_movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([MigrateMovieTopRatedBloc, GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MigrateMovieTopRatedBloc migrateMovieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    migrateMovieTopRatedBloc = MigrateMovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(migrateMovieTopRatedBloc.state, MigrateMovieTopRatedEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<MigrateMovieTopRatedBloc, MigrateMovieTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(movieList));
        return migrateMovieTopRatedBloc;
      },
      act: (bloc) => bloc.add(MigrateMovieTopRatedGetEvent()),
      expect: () => [MigrateMovieTopRatedLoading(), MigrateMovieTopRatedLoaded(movieList)],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MigrateMovieTopRatedBloc, MigrateMovieTopRatedState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateMovieTopRatedBloc;
      },
      act: (bloc) => bloc.add(MigrateMovieTopRatedGetEvent()),
      expect: () =>
      [MigrateMovieTopRatedLoading(), MigrateMovieTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  },);
}