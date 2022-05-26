import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTvls {
  final TvlsRepository _repository;

  GetWatchlistTvls(this._repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return _repository.getWatchlistTv();
  }
}
