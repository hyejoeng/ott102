import 'package:flutter/material.dart';
import 'package:ott102/persentation/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff232937),
          actions: [
            Container(
              width: screensize(context).width,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset('asset/images/showtime_logo.png', width: 30),
                    SizedBox(width: 8),
                    Expanded(child: SizedBox())
                    // SingleChildScrollView(
                    //   child: Expanded(
                    //       child:
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Text('main screen'),
        ),
      ),
    );
  }
}
