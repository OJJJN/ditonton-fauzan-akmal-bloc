import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingTvls {
  final TvlsRepository repository;

  GetNowPlayingTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getNowPlayingTv();
  }
}
