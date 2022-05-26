import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TvlsRepository {
  Future<Either<Failure, List<Tvls>>> getNowPlayingTv();
  Future<Either<Failure, List<Tvls>>> getPopularTv();
  Future<Either<Failure, List<Tvls>>> getTopRatedTv();
  Future<Either<Failure, TvlsDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tvls>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tvls>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvlsDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvlsDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<Tvls>>> getWatchlistTv();
}
