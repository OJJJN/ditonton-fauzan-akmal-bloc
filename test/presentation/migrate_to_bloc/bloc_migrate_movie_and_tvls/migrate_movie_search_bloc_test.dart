import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_search_movie/migrate_movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'migrate_movie_search_bloc_test.mocks.dart';

@GenerateMocks([MigrateMovieSearchBloc, SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MigrateMovieSearchBloc migrateMovieSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    migrateMovieSearchBloc = MigrateMovieSearchBloc(
      searchMovies: mockSearchMovies,
    );
  });

  const query = "originalTitle";
  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(migrateMovieSearchBloc.state, MigrateMovieSearchEmpty());
  });

  blocTest<MigrateMovieSearchBloc, MigrateMovieSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(movieList));
      return migrateMovieSearchBloc;
    },
    act: (bloc) => bloc.add(const MigrateMovieSearchQueryEvent(query)),
    expect: () => [MigrateMovieSearchLoading(), MigrateMovieSearchLoaded(movieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  group('Search Movies BLoC Test', () {
    blocTest<MigrateMovieSearchBloc, MigrateMovieSearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateMovieSearchBloc;
      },
      act: (bloc) => bloc.add(const MigrateMovieSearchQueryEvent(query)),
      expect: () =>
      [MigrateMovieSearchLoading(), const MigrateMovieSearchError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      },
    );
  },
  );
}