import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';

class SearchTvls {
  final TvlsRepository repository;

  SearchTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute(String query) {
    return repository.searchTv(query);
  }
}
