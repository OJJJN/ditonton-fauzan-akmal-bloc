import 'package:ditonton/domain/entities/tvls/tvls.dart';
import 'package:ditonton/domain/entities/tvls/tvls_detail.dart';
import 'package:equatable/equatable.dart';

class TvlsTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvlsTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvlsTable.fromEntity(TvlsDetail tv) => TvlsTable(
    id: tv.id,
    name: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview,
  );

  factory TvlsTable.fromMap(Map<String, dynamic> map) => TvlsTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Tvls toEntity() => Tvls.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
