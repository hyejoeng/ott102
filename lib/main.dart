import 'package:flutter/material.dart';
import 'package:ott102/persentation/provider/main_tab_provider.dart';
import 'package:ott102/persentation/view/screens/main_tab_screen.dart';

import 'data/repository/movie_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mainTabProvider = MainTabProvider(movieRepository: MovieRepository());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
        primaryColor: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      home: MainTabScreen(mainTabProvider: mainTabProvider,),
    );
  }
}
