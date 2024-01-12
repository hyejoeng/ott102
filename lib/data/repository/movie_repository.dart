import 'dart:convert';

import 'package:ott102/data/model/genre_model.dart';
import 'package:http/http.dart';
import 'package:ott102/data/model/now_playing_model.dart';
import 'package:ott102/data/model/upcoming_model.dart';
import '../model/top_rated_model.dart';

class MovieRepository {
  final _client = Client();

  static const String _baseUrl = 'api.themoviedb.org';

  static const String _apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYTg1OTFjN2U0YzVjYWVjYjRlMDhhNzI3ODA2YWYxOSIsInN1YiI6IjY1OGQyYThmNTVjMWY0NjFkNDM5YTM3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t7K3U8egkt_gYmvaCGC9Hdc9OjDRzLtl0l4XA3i1_o4';

  static final headers = {'Authorization': 'Bearer $_apiKey'};

  Future<Response?> _apiCallHandling({required Uri apiUri, Map<String, String>? headers}) async {
    try {
      final response = await _client.get(apiUri, headers: headers);
      if (response.statusCode != 200) {
        //todo 앱 종료 로직
        return null;
      }
      return response;
    } catch (_) {
      return null;
    }
  }

  // 장르 리스트
  Future<List<GenreModel>> getGenreList() async {
    final List<GenreModel> genreList = [];
    final apiUrl = Uri.https(
      _baseUrl, '/3/genre/movie/list', {'language':'ko-KR', 'region':'KR'},
    );

    final response = await _apiCallHandling(apiUri: apiUrl, headers: headers);
    if (response == null) {
      return [];
    }

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

    for (var genreJson in responseBody['genres']) {
      genreList.add(GenreModel.fromJson(genreJson as Map<String, dynamic>));
    }

    return genreList;
  }

  // 인기 영화
  Future<List<TopRatedModel>> getTopRatedMovieList() async {
    final List<TopRatedModel> topRatedMovieList = [];

    final apiUrl = Uri.https(
      _baseUrl, '/3/movie/top_rated', {'language':'ko-KR', 'region':'KR', 'page':'1'},
    );

    final response = await _apiCallHandling(apiUri: apiUrl, headers: headers);
    if (response == null) return [];

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

    for (var topRatedMovie in responseBody['results']) {
      topRatedMovieList.add(TopRatedModel.fromJson(topRatedMovie as Map<String, dynamic>));
    }

    return topRatedMovieList;
  }

  // 방영 중인 영화
  Future<List<NowPlayingModel>> getNowPlayingMovieList() async {
    final List<NowPlayingModel> nowPlayingMovieList = [];

    final apiUrl = Uri.https(
      _baseUrl, '/3/movie/now_playing', {'language':'ko-KR', 'region':'KR', 'page':'1'},
    );

    final response = await _apiCallHandling(apiUri: apiUrl, headers: headers);
    if (response == null) return [];

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

    for (var nowPlayingMovie in responseBody['results']) {
      nowPlayingMovieList.add(NowPlayingModel.fromJson(nowPlayingMovie as Map<String, dynamic>));
    }

    return nowPlayingMovieList;
  }

  // 공개 예정
  Future<List<UpcomingModel>> getUpcomingMovieList() async {
    final List<UpcomingModel> upcomingMovieList = [];

    final apiUrl = Uri.https(
      _baseUrl, '/3/movie/upcoming', {'language':'ko-KR', 'region':'KR', 'page':'1'},
    );

    final response = await _apiCallHandling(apiUri: apiUrl, headers: headers);
    if (response == null) return [];

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

    for (var upcomingMovie in responseBody['results']) {
      upcomingMovieList.add(UpcomingModel.fromJson(upcomingMovie as Map<String, dynamic>));
    }

    return upcomingMovieList;
  }

}