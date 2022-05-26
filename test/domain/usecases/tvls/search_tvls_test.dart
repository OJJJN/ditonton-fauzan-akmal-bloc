import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/search_tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late SearchTvls usecase;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvlsRepository();
    usecase = SearchTvls(mockTvRepository);
  });

  final tTv = <Tvls>[];
  final tQuery = 'Game of throne';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
