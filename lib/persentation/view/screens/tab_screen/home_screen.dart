import 'package:flutter/material.dart';
import 'package:ott102/data/model/now_playing_model.dart';
import 'package:ott102/data/model/top_rated_model.dart';
import 'package:ott102/data/repository/movie_repository.dart';
import 'package:ott102/persentation/provider/main_tab_provider.dart';
import 'package:ott102/persentation/utils.dart';

import '../loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.mainTabProvider});

  final MainTabProvider mainTabProvider;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  VoidCallback listenSetState() => () => setState(() {});

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.mainTabProvider.addListener(listenSetState);
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('disposse');
    widget.mainTabProvider.removeListener(listenSetState);
  }

  @override
  Widget build(BuildContext context) {
    final List<TopRatedModel> topRatedMovieList = widget.mainTabProvider.topRatedMovieList;
    final List<NowPlayingModel> nowPlayingMovieList = widget.mainTabProvider.nowPlayingMovieList;
    final List<NowPlayingModel> latesMovieList = widget.mainTabProvider.latestMovieList;

    if (topRatedMovieList.isEmpty || nowPlayingMovieList.isEmpty || latesMovieList.isEmpty) {
      return loadingWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
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
                      topRatedMovieList[0].posterPath,
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
                          topRatedMovieList[0].voteAverage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        getStarRating(
                            topRatedMovieList[0].star),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: screensize(context).height * 0.1,
                          child: getGenreIdList(widget.mainTabProvider),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            movieList('방영 중인 작품', context, nowPlayingMovieList),
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
                                topRatedMovieList.length - 1,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Image.network(
                                topRatedMovieList[index + 1].posterPath,
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
            movieList('최근 개봉', context, widget.mainTabProvider.latestMovieList),
          ],
        ),
      ),
    );
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
  Widget getStarRating(int rating) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (index) => index < rating
        ? const Icon(Icons.star, color: Colors.yellow)
        : const Icon(Icons.star_border_outlined, color: Colors.yellow),
    ),
  );

  // 장르
  Widget getGenreIdList(MainTabProvider mainTabProvider) {
    final allGenreList = mainTabProvider.genreList;

    final topRatedGenreIdList = mainTabProvider.topRatedMovieList[0].genreIds;

    final mainGenresText = allGenreList
        .where((element) => topRatedGenreIdList.contains(element.id))
        .fold('', (previousValue, element) => '$previousValue | ${element.name}').substring(3);

    return  Text(mainGenresText, style: const TextStyle(color: Colors.white));
  }
}
