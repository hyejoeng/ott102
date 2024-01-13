import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ott102/data/repository/movie_repository.dart';
import 'package:ott102/persentation/provider/main_tab_provider.dart';
import 'package:ott102/persentation/utils.dart';

import '../../../../data/model/upcoming_model.dart';
import '../loading.dart';

class UpComingScreen extends StatefulWidget {
  const UpComingScreen({super.key});

  @override
  State<UpComingScreen> createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  final mainTabProvider = MainTabProvider(movieRepository: MovieRepository());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainTabProvider.updateUpcomingMovieList();

      mainTabProvider.addListener(() => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<UpcomingModel> upcomingMovieList =
        mainTabProvider.upcomingMovieList;

    if (upcomingMovieList.isEmpty) return loadingWidget();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 5),
            const Text(
              '공개 예정 작픔',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 15),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 210,
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 18,
              ),
              shrinkWrap: true,
              itemCount: upcomingMovieList.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    upcomingMovieList[index].posterPath,
                    height: screensize(context).height * 0.23,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    upcomingMovieList[index].releasceDate,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
