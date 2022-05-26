import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper_tvls.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:ditonton/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tvls_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvls_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:ditonton/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:ditonton/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:ditonton/domain/usecases/tvls/search_tvls.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_detail_movie/migrate_movie_detail_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_movie_now_playing/migrate_movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_popular_movie/migrate_movie_popular_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_recommendation_movie/migrate_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_search_movie/migrate_movie_search_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_top_rated_movie/migrate_movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_movie/bloc_migrate_watchlist_movie/migrate_movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_detail_tvls/migrate_tvls_detail_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_on_air_tvls/migrate_tvls_on_air_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_popular_tvls/migrate_tvls_popular_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_recommendation_tvls/migrate_tvls_recommendation_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_search_tvls/migrate_tvls_search_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_top_rated_tvls/migrate_tvls_top_rated_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_watchlist_tvls/migrate_tvls_watchlist_bloc.dart';

import 'package:ditonton/data/datasources/ssl_pinning/ssl_pinning.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => MigrateMovieDetailBloc(
    getMigrateMovieDetail: locator(),
  ));
  locator.registerFactory(() => MigrateMovieNowPlayingBloc(locator()),
  );
  locator.registerFactory(() => MigrateMoviePopularBloc(locator()),
  );
  locator.registerFactory(() => MigrateMovieRecommendationBloc(
    getMigrateMovieRecommendations: locator(),
  ));
  locator.registerFactory(() => MigrateMovieSearchBloc(
    searchMovies: locator(),
  ));
  locator.registerFactory(() => MigrateMovieTopRatedBloc(locator()),
  );
  locator.registerFactory(() => MigrateTvlsDetailBloc(
    getMigrateTvlsDetail: locator(),
  ));
  locator.registerFactory(() => MigrateTvlsOnAirBloc(locator()),
  );
  locator.registerFactory(() => MigrateTvlsPopularBloc(locator()),
  );
  locator.registerFactory(() => MigrateTvlsRecommendationBloc(
    getTvlsRecommendations: locator(),
  ));
  locator.registerFactory(() => MigrateTvlsSearchBloc(
    searchMigrateTvls: locator(),
  ));
  locator.registerFactory(() => MigrateTvlsTopRatedBloc(locator()),
  );
  locator.registerFactory(() => MigrateMovieWatchlistBloc(
    getWatchlistMovies: locator(),
    getWatchListStatus: locator(),
    saveWatchlist: locator(),
    removeWatchlist: locator(),
  ));
  locator.registerFactory(() => MigrateTvlsWatchlistBloc(
    getWatchlistTv: locator(),
    getWatchListStatus: locator(),
    saveWatchlist: locator(),
    removeWatchlist: locator(),
  ));



  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvls(locator()));
  locator.registerLazySingleton(() => GetPopularTvls(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvls(locator()));
  locator.registerLazySingleton(() => GetTvlsDetail(locator()));
  locator.registerLazySingleton(() => GetTvlsRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvls(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvls(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvls(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvls(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvls(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvlsRepository>(() => TvlsRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvlsRemoteDataSource>(() => TvlsRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvlsLocalDataSource>(() => TvlsLocalDataSourceImpl(databaseHelpertvls: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvls>(() => DatabaseHelperTvls());

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
}
