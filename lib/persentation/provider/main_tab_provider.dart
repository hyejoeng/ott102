import 'package:flutter/cupertino.dart';
import 'package:ott102/data/model/top_rated_movie.dart';

import '../../data/model/genre_model.dart';
import '../../data/repository/movie_repository.dart';

class MainTabProvider extends ChangeNotifier {
  final MovieRepository movieRepository;

  // late PageController mainTabController;

  MainTabProvider({required this.movieRepository});

  List<GenreModel> genreList = [];

  Future<void> updateGenreList() async {
    genreList = await movieRepository.getGenreList();
    notifyListeners();
  }

  // List<TopRatedMovieModel> topRatedMovieModel = [];
  //
  // Future<void> updateTopRatedMovieList() async {
  //   topRatedMovieModel = await movieRepository.getTopRatedMovieList();
  //   notifyListeners();
  // }

  // void changeTabPosition(int index) {
  //   mainTabController.jumpToPage(index);
  //   notifyListeners();
  // }
}

// class StoreModel with ChangeNotifier {
//   var isLoading = false;
//   List<Store> stores = [];
//
//   final _storeRepository = StoreRepository();
//   final _locationRepository = LocationRepository();
//
//   StoreModel() {
//     fetch();
//   }
//
//   Future fetch() async {
//     isLoading = true;
//     notifyListeners();
//
//     Position position = await _locationRepository.getCurrentLocation();
//
//     stores = await _storeRepository.fetch(
//       position.latitude,
//       position.longitude,
//     );
//     isLoading = false;
//     notifyListeners();
//   }
// }