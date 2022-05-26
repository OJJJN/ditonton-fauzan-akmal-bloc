import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetPopularTvls usecase;
  late MockTvlsRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvlsRepository();
    usecase = GetPopularTvls(mockTvRpository);
  });

  final tTv = <Tvls>[];

  group('Get Popular Tv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvRpository.getPopularTv())
                .thenAnswer((_) async => Right(tTv));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTv));
          });
    });
  });
}
