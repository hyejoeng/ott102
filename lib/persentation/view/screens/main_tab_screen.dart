import 'package:flutter/material.dart';
import 'package:ott102/persentation/provider/main_tab_provider.dart';
import 'package:ott102/persentation/utils.dart';
import 'package:ott102/persentation/view/screens/tab_screen/download_screen.dart';
import 'package:ott102/persentation/view/screens/tab_screen/home_screen.dart';
import 'package:ott102/persentation/view/screens/tab_screen/profile_screen.dart';
import 'package:ott102/persentation/view/screens/tab_screen/search_screen.dart';
import 'package:ott102/persentation/view/screens/tab_screen/upcoming_screen.dart';

class MainTabScreen extends StatefulWidget {
  final MainTabProvider mainTabProvider;

  const MainTabScreen({super.key, required this.mainTabProvider});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  static const List<Widget> pages = [
    HomeScreen(),
    UpComingScreen(),
    DownloadScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  int _currentIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.mainTabProvider.mainTabController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.mainTabProvider.updateGenreList();
      widget.mainTabProvider.updateTopRatedMovieList();
      widget.mainTabProvider.addListener(() => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    // 만약에 값이 없다면
    if (widget.mainTabProvider.genreList.isEmpty) loadingWidget;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff232937),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
          actions: [
            Container(
              width: screensize(context).width,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset('asset/images/showtime_logo.png', width: 30),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.mainTabProvider.genreList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.mainTabProvider.genreList[index].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTap,
          currentIndex: _currentIndex,
          backgroundColor: const Color(0xFF232937),
          selectedLabelStyle: const TextStyle(color: Colors.deepOrange),
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(size: 30),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'HOME',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play),
              label: '공개예정',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined),
              label: '다운로드',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '검색',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink,
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: const Center(
                  child: Text('한',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              label: '프로필',
            )
          ],
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('정보를 가져오는 중'),
          SizedBox(height: 10),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
