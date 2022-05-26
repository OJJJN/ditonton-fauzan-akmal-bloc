import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetTvlsRecommendations usecase;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvlsRepository();
    usecase = GetTvlsRecommendations(mockTvRepository);
  });

  final tId = 1;
  final tTv = <Tvls>[];

  test('should get list of tv recommendations from the repository',
          () async {
        // arrange
        when(mockTvRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTv));
      });
}
