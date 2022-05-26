import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_detail_tvls/migrate_tvls_detail_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_recommendation_tvls/migrate_tvls_recommendation_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_watchlist_tvls/migrate_tvls_watchlist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class TvlsDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvlsDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvlsDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<MigrateTvlsDetailBloc>()
          .add(GetMigrateTvlsDetailEvent(widget.id));
      context
          .read<MigrateTvlsRecommendationBloc>()
          .add(GetMigrateTvlsRecommendationEvent(widget.id));
      context
          .read<MigrateTvlsWatchlistBloc>()
          .add(MigrateGetStatusTvlsEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    TvlsRecommendationState tvlsRecommendations =
        context.watch<MigrateTvlsRecommendationBloc>().state;
    return Scaffold(
      body: BlocListener<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
        listener: (_, state) {
          if (state is MigrateTvlsWatchlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            context
                .read<MigrateTvlsWatchlistBloc>()
                .add(MigrateGetStatusTvlsEvent(widget.id));
          }
        },
        child: BlocBuilder<MigrateTvlsDetailBloc, MigrateTvlsDetailState>(
          builder: (context, state) {
            if (state is MigrateTvlsDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MigrateTvlsDetailLoaded) {
              final tv = state.result;
              bool isAddedToWatchlistTv = (context.watch<MigrateTvlsWatchlistBloc>().state
              is MigrateTvlsWatchlistStatusLoaded)
                  ? (context.read<MigrateTvlsWatchlistBloc>().state
              as MigrateTvlsWatchlistStatusLoaded)
                  .result
                  : false;
              return SafeArea(
                child: DetailContent(
                  tv,
                  tvlsRecommendations is TvlsRecommendationLoaded
                      ? tvlsRecommendations.tv
                      : List.empty(),
                  isAddedToWatchlistTv,
                ),
              );
            } else {
              return Text("Empty");
            }
          },
        ),
      ),);
  }
}

class DetailContent extends StatelessWidget {
  final TvlsDetail tv;
  final List<Tvls> recommendations;
  final bool isAddedWatchlistTv;

  DetailContent(this.tv, this.recommendations, this.isAddedWatchlistTv);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlistTv) {
                                  BlocProvider.of<MigrateTvlsWatchlistBloc>(context)
                                    ..add(MigrateAddItemTvlsEvent(tv));
                                } else {
                                  BlocProvider.of<MigrateTvlsWatchlistBloc>(context)
                                    ..add(MigrateRemoveItemTvlsEvent(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlistTv
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              (tv.firstAirDate),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MigrateTvlsRecommendationBloc,
                                TvlsRecommendationState>(
                              builder: (context, state) {
                                if (state is MigrateTvlsRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MigrateTvlsRecommendationError) {
                                  return Text(state.message);
                                } else if (state is TvlsRecommendationLoaded) {
                                  final recommendations = state.tv;
                                  if (recommendations.isEmpty) {
                                    return const Text("Tidak ada tv recommendations");
                                  }
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvlsDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
