import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late SaveWatchlistTvls usecase;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvlsRepository();
    usecase = SaveWatchlistTvls(mockTvRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlistTv(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
