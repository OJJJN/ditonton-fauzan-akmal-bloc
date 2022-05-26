import 'package:ditonton/data/models/tvls/tvls_model.dart';
import 'package:equatable/equatable.dart';

class TvlsResponse extends Equatable {
  final List<TvlsModel> tvList;

  TvlsResponse({required this.tvList});

  factory TvlsResponse.fromJson(Map<String, dynamic> json) => TvlsResponse(
    tvList: List<TvlsModel>.from((json["results"] as List)
        .map((x) => TvlsModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvList];
}
