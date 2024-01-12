import 'package:flutter/material.dart';
import 'package:ott102/data/model/now_playing_model.dart';
import 'package:ott102/data/model/top_rated_model.dart';
import 'package:ott102/data/repository/movie_repository.dart';
import 'package:ott102/persentation/provider/main_tab_provider.dart';
import 'package:ott102/persentation/utils.dart';

import '../loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final mainTabProvider = MainTabProvider(movieRepository: MovieRepository());

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    await Future.wait([
      mainTabProvider.updateGenreList(),
      mainTabProvider.updateTopRatedMovieList(),
      mainTabProvider.updateNowPlayingMovieList(),
      mainTabProvider.updateLatesMovieList(),
      mainTabProvider.updateUpcomingMovieList(),
    ]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<TopRatedModel> topRatedMovieList =
        mainTabProvider.topRatedMovieList;
    final List<NowPlayingModel> nowPlayingMovieList =
        mainTabProvider.nowPlayingMovieList;
    final List<NowPlayingModel> latesMovieList =
        mainTabProvider.latestMovieList;

    // if (topRatedMovieList.isEmpty || nowPlayingMovieList.isEmpty || latesMovieList) {
    //   return loadingWidget();
    // }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        fetchData();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screensize(context).height * 0.82,
              child: Stack(
                children: [
                  ShaderMask(
                    child: Image.network(
                      mainTabProvider.topRatedMovieList[0].posterPath,
                      height: screensize(context).height * 0.7,
                    ),
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white,
                        Colors.white,
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.15, 0.8, 1],
                    ).createShader(bounds),
                  ),
                  Positioned(
                    width: screensize(context).width,
                    bottom: screensize(context).height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          mainTabProvider.topRatedMovieList[0].voteAverage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        getStarRating(
                            mainTabProvider.topRatedMovieList[0].star),
                        const SizedBox(height: 10),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: getGenreIdList(mainTabProvider),
                        // )
                        SizedBox(
                          height: screensize(context).height * 0.1,
                          child: getGenreIdList(mainTabProvider),
                        )
                        // SizedBox(
                        //   height: screensize(context).height * 0.05,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 3,
                        //     itemBuilder: (context, index) => Text('List $index'),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            movieList('방영 중인 작품', context, mainTabProvider.nowPlayingMovieList),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '인기 작품',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: screensize(context).height * 0.25,
                      child: Row(
                        children: [
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                mainTabProvider.topRatedMovieList.length - 1,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Image.network(
                                mainTabProvider
                                    .topRatedMovieList[index + 1].posterPath,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            movieList('최근 개봉', context, mainTabProvider.latestMovieList),
          ],
        ),
      ),
    );
  }
}

Widget movieList(String text, BuildContext context, movieList) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: screensize(context).height * 0.25,
              child: Row(
                children: [
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.network(
                        movieList[index].posterPath,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

// 별점
Row getStarRating(int rating) {
  List<Widget> starRating = [];

  for (int i = 0; i < 5; i++) {
    var starIcon = const Icon(Icons.star_border_outlined, color: Colors.yellow);

    if (i < rating) {
      starIcon = const Icon(
        Icons.star,
        color: Colors.yellow,
      );
    }

    starRating.add(starIcon);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: starRating,
  );
}

// 장르
Widget getGenreIdList(MainTabProvider mainTabProvider) {
  List<String> genreList = [];

  final genreId = mainTabProvider.genreList;

  final topRatedgenreId = mainTabProvider.topRatedMovieList[0].genreIds;

  for (int i = 0; i < genreId.length; i++) {
    if (genreId[i].id == topRatedgenreId) {
      genreList.add(genreId[i].name);
    }
  }

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: genreList.length,
    itemBuilder: (context, index) => Text(genreList[index], style: TextStyle(color: Colors.white)),
  );
}
