import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_tvls_page.dart';
import 'package:ditonton/presentation/pages/search_page_tvls.dart';
import 'package:ditonton/presentation/pages/top_rated_tvls_page.dart';
import 'package:ditonton/presentation/pages/tvls_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tvls_page.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_on_air_tvls/migrate_tvls_on_air_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_popular_tvls/migrate_tvls_popular_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_top_rated_tvls/migrate_tvls_top_rated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvlsPage extends StatefulWidget {
  @override
  _HomeTvlsPageState createState() => _HomeTvlsPageState();
  static const ROUTE_NAME = '/tv';
}

class _HomeTvlsPageState extends State<HomeTvlsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<MigrateTvlsOnAirBloc>().add(MigrateTvlsOnAirGetEvent());
      context.read<MigrateTvlsPopularBloc>().add(MigrateTvlsPopularGetEvent());
      context.read<MigrateTvlsTopRatedBloc>().add(MigrateTvlsTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Television'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: Text('Watchlist'),
              leading: Icon(Icons.save_alt),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.movie),
                  title: Text('Movie'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistMoviesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('Television'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistTvlsPage.ROUTE_NAME);
                  },
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvlsPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tv on Air',
                style: kHeading6,
              ),
              BlocBuilder<MigrateTvlsOnAirBloc, MigrateTvlsOnAirState>(
                builder: (context, state) {
                  if (state is MigrateTvlsOnAirLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MigrateTvlsOnAirLoaded) {
                    return TvList(state.result);
                  } else if (state is MigrateTvlsOnAirError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvlsPage.ROUTE_NAME),
              ),
              BlocBuilder<MigrateTvlsPopularBloc, MigrateTvlsPopularState>(
                builder: (context, state) {
                  if (state is MigrateTvlsPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MigrateTvlsPopularLoaded) {
                    return TvList(state.result);
                  } else if (state is MigrateTvlsPopularError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvlsPage.ROUTE_NAME),
              ),
              BlocBuilder<MigrateTvlsTopRatedBloc, MigrateTvlsTopRatedState>(
                builder: (context, state) {
                  if (state is MigrateTvlsTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MigrateTvlsTopRatedLoaded) {
                    return TvList(state.result);
                  } else if (state is MigrateTvlsTopRatedError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tvls> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvlsDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
