import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';

class SaveWatchlistTvls {
  final TvlsRepository repository;

  SaveWatchlistTvls(this.repository);

  Future<Either<Failure, String>> execute(TvlsDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
