import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper_tvls.dart';
import 'package:ditonton/data/models/tvls/tvls_table.dart';

abstract class TvlsLocalDataSource {
  Future<String> insertWatchlistTv(TvlsTable tv);
  Future<String> removeWatchlistTv(TvlsTable tv);
  Future<TvlsTable?> getTvById(int id);
  Future<List<TvlsTable>> getWatchlistTv();
}

class TvlsLocalDataSourceImpl implements TvlsLocalDataSource {
  final DatabaseHelperTvls databaseHelpertvls;

  TvlsLocalDataSourceImpl({required this.databaseHelpertvls});

  @override
  Future<String> insertWatchlistTv(TvlsTable tv) async {
    try {
      await databaseHelpertvls.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvlsTable tv) async {
    try {
      await databaseHelpertvls.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvlsTable?> getTvById(int id) async {
    final result = await databaseHelpertvls.getTvById(id);
    if (result != null) {
      return TvlsTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvlsTable>> getWatchlistTv() async {
    final result = await databaseHelpertvls.getWatchlistTv();
    return result.map((data) => TvlsTable.fromMap(data)).toList();
  }
}
