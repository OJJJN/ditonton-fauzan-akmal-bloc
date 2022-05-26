import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';

class GetPopularTvls {
  final TvlsRepository repository;

  GetPopularTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getPopularTv();
  }
}
