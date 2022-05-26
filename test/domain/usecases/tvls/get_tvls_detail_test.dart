import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetTvlsDetail usecase;
  late MockTvlsRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvlsRepository();
    usecase = GetTvlsDetail(mockMovieRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}
