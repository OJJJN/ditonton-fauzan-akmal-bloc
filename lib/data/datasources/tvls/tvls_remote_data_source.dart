import 'dart:convert';

import 'package:ditonton/data/models/tvls/tvls_detail_model.dart';
import 'package:ditonton/data/models/tvls/tvls_model.dart';
import 'package:ditonton/data/models/tvls/tvls_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class TvlsRemoteDataSource {
  Future<List<TvlsModel>> getNowPlayingTv();
  Future<List<TvlsModel>> getPopularTv();
  Future<List<TvlsModel>> getTopRatedTv();
  Future<TvlsDetailResponse> getTvDetail(int id);
  Future<List<TvlsModel>> getTvRecommendations(int id);
  Future<List<TvlsModel>> searchTv(String query);
}

class TvlsRemoteDataSourceImpl implements TvlsRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvlsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvlsModel>> getNowPlayingTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvlsResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvlsDetailResponse> getTvDetail(int id) async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvlsDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvlsModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvlsResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvlsModel>> getPopularTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvlsResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvlsModel>> getTopRatedTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvlsResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvlsModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvlsResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
