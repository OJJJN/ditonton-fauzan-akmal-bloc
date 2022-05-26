import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTvlsRecommendations {
  final TvlsRepository repository;

  GetTvlsRecommendations(this.repository);

  Future<Either<Failure, List<Tvls>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
