import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/search_tvls.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_search_tvls/migrate_tvls_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'migrate_tvls_search_bloc_test.mocks.dart';

@GenerateMocks([MigrateTvlsSearchBloc, SearchTvls])
void main() {
  late MockSearchTvls mockSearchTvls;
  late MigrateTvlsSearchBloc migrateTvlsSearchBloc;

  setUp(() {
    mockSearchTvls = MockSearchTvls();
    migrateTvlsSearchBloc = MigrateTvlsSearchBloc(
      searchMigrateTvls: mockSearchTvls,
    );
  });

  const query = "originalTitle";
  final tvList = <Tvls>[];

  test("initial state should be empty", () {
    expect(migrateTvlsSearchBloc.state, MigrateTvlsSearchEmpty());
  });

  blocTest<MigrateTvlsSearchBloc, MigrateTvlsSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchTvls.execute(query))
          .thenAnswer((_) async => Right(tvList));
      return migrateTvlsSearchBloc;
    },
    act: (bloc) => bloc.add(const MigrateTvlsSearchQueryEvent(query)),
    expect: () => [MigrateTvlsSearchLoading(), MigrateTvlsSearchLoaded(tvList)],
    verify: (bloc) {
      verify(mockSearchTvls.execute(query));
    },
  );

  group('Search Tv BLoC Test', () {
    blocTest<MigrateTvlsSearchBloc, MigrateTvlsSearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvls.execute(query))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return migrateTvlsSearchBloc;
      },
      act: (bloc) => bloc.add(const MigrateTvlsSearchQueryEvent(query)),
      expect: () =>
      [MigrateTvlsSearchLoading(), const MigrateTvlsSearchError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchTvls.execute(query));
      },
    );
  },
  );
}