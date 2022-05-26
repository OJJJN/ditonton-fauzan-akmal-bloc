import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/migrate_to_bloc/bloc_migrate_tvls/bloc_migrate_watchlist_tvls/migrate_tvls_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/tvls_card_list.dart';
import 'package:flutter/material.dart';


class WatchlistTvlsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvlsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MigrateTvlsWatchlistBloc>().add(MigrateTvlsGetListEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MigrateTvlsWatchlistBloc>().add(MigrateTvlsGetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MigrateTvlsWatchlistBloc, MigrateTvlsWatchlistState>(
          builder: (context, state) {
            if (state is MigrateTvlsWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MigrateTvlsWatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvlsCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Errorrr"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
