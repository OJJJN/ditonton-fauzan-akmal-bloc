import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/buttom_bar.dart';
import 'package:ditonton/presentation/pages/home_tvls_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvls_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_page_tvls.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvls_page.dart';
import 'package:ditonton/presentation/pages/tvls_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tvls_page.dart';
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


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// migrate bloc movie
        BlocProvider(create: (_) => di.locator<MigrateMovieDetailBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateMoviePopularBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateMovieRecommendationBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateMovieSearchBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateMovieTopRatedBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateMovieNowPlayingBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateMovieWatchlistBloc>(),
        ),

        /// migrate bloc tvls
        BlocProvider(create: (_) => di.locator<MigrateTvlsDetailBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateTvlsRecommendationBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateTvlsSearchBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateTvlsPopularBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateTvlsTopRatedBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateTvlsOnAirBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MigrateTvlsWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: BottomBar(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTvlsPage());
            case PopularTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvlsPage());
            case TopRatedTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvlsPage());
            case TvlsDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvlsDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvlsPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvlsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvlsPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

