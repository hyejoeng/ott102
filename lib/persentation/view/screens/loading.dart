import 'package:flutter/material.dart';

Widget loadingWidget() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('정보를 가져오는 중', style: TextStyle(color: Colors.white),),
        SizedBox(height: 10),
        CircularProgressIndicator(),
      ],
    ),
  );
}