import 'package:ditonton/domain/repositories/tvls_repository.dart';

class GetWatchListStatusTvls {
  final TvlsRepository repository;

  GetWatchListStatusTvls(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
