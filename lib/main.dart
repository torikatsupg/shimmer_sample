import 'package:flutter/material.dart';
import 'package:shimmer_sample/movie_placeholder.dart';
import 'package:shimmer_sample/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Shimmer(
              child: MoviePlaceholder(),
            ),
          ],
        ),
      )),
    );
  }
}
