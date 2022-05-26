import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_popular_tvls/migrate_tvls_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/tvls_card_list.dart';
import 'package:flutter/material.dart';


class PopularTvlsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvlsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<MigrateTvlsPopularBloc>().add(MigrateTvlsPopularGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MigrateTvlsPopularBloc, MigrateTvlsPopularState>(
          builder: (context, state) {
            if (state is MigrateTvlsPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MigrateTvlsPopularLoaded) {
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
                child: Text('Errrorr'),
              );
            }
          },
        ),
      ),
    );
  }
}
