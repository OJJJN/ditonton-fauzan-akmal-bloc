import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';

class RemoveWatchlistTvls {
  final TvlsRepository repository;

  RemoveWatchlistTvls(this.repository);

  Future<Either<Failure, String>> execute(TvlsDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
