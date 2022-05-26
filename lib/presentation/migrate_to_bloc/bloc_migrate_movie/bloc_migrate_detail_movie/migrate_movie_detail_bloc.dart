import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'migrate_movie_detail_event.dart';
part 'migrate_movie_detail_state.dart';

class MigrateMovieDetailBloc extends Bloc<MigrateMovieDetailEvent, MigrateMovieDetailState> {
  final GetMovieDetail getMigrateMovieDetail;

  MigrateMovieDetailBloc({
    required this.getMigrateMovieDetail,
  }) : super(MigrateMovieDetailEmpty()) {
    on<GetMigrateMovieDetailEvent>((event, emit) async {
      emit(MigrateMovieDetailLoading());
      final result = await getMigrateMovieDetail.execute(event.id);

      result.fold(
            (failure) {
          emit(MigrateMovieDetailError(failure.message));
        },
            (data) {
          emit(MigrateMovieDetailLoaded(data));
        },
      );
    });
  }
}