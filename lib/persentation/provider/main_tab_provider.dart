import 'package:flutter/cupertino.dart';
import 'package:ott102/data/model/top_rated_model.dart';

import '../../data/model/genre_model.dart';
import '../../data/model/now_playing_model.dart';
import '../../data/model/upcoming_model.dart';
import '../../data/repository/movie_repository.dart';

class MainTabProvider extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MainTabProvider({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;


  void changeTabPosition(int changeIndex) {
    _currentIndex = changeIndex;
    notifyListeners();
  }

  // 장르 리스트
  List<GenreModel> genreList = [];
  Future<void> updateGenreList() async {
    genreList = await _movieRepository.getGenreList();
    notifyListeners();
  }

  // 인기영화
  List<TopRatedModel> topRatedMovieList = [];
  Future<void> updateTopRatedMovieList() async {
    topRatedMovieList = await _movieRepository.getTopRatedMovieList();
    notifyListeners();
  }

  // 방영 중
  List<NowPlayingModel> nowPlayingMovieList = [];
  Future<void> updateNowPlayingMovieList() async {
    nowPlayingMovieList = await _movieRepository.getNowPlayingMovieList();
    notifyListeners();
  }

  // 최근 개봉
  List<NowPlayingModel> latestMovieList = [];
  Future<void> updateLatesMovieList() async {
    latestMovieList = await _movieRepository.getNowPlayingMovieList();
    latestMovieList.sort((a, b) => a.releaseDate.compareTo(b.releaseDate),);
    notifyListeners();
  }

  // 공개 예정
  List<UpcomingModel> upcomingMovieList = [];
  Future<void> updateUpcomingMovieList() async {
    upcomingMovieList = await _movieRepository.getUpcomingMovieList();
    notifyListeners();
  }
}