import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetTopRatedTvls usecase;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvlsRepository();
    usecase = GetTopRatedTvls(mockTvRepository);
  });

  final tTv = <Tvls>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
