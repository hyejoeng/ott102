import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ott102/data/repository/movie_repository.dart';
import 'package:ott102/persentation/provider/main_tab_provider.dart';
import 'package:ott102/persentation/utils.dart';

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

    mainTabProvider.updateUpcomingMovieList();

    setState(() {});
    // fetchData();
  }

  fetchData() async {
    await Future.wait([
      mainTabProvider.updateUpcomingMovieList(),
    ]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('공개 예정 작픔',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(
          height: screensize(context).height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => Row(
              children: [
                SizedBox(
                  width: screensize(context).width * 0.33333,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                        mainTabProvider.latestMovieList[index].posterPath),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
