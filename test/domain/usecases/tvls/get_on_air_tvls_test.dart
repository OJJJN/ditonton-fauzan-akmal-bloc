import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetNowPlayingTvls usecase;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvlsRepository();
    usecase = GetNowPlayingTvls(mockTvRepository);
  });

  final tTv = <Tvls>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getNowPlayingTv())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
