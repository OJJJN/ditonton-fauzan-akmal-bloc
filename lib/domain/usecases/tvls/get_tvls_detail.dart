import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTvlsDetail {
  final TvlsRepository repository;

  GetTvlsDetail(this.repository);

  Future<Either<Failure, TvlsDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
