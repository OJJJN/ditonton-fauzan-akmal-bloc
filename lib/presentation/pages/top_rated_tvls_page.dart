import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_top_rated_tvls/migrate_tvls_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/tvls_card_list.dart';



class TopRatedTvlsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvlsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MigrateTvlsTopRatedBloc>().add(MigrateTvlsTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MigrateTvlsTopRatedBloc, MigrateTvlsTopRatedState>(
          builder: (context, state) {
            if (state is MigrateTvlsTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MigrateTvlsTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.result[index];
                  return TvlsCard(tvs);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
