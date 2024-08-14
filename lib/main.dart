import 'package:flutter/material.dart';
import 'package:itunes_search/providers/search_screen.dart';

void main() {
  runApp(ItunesSearchApp());
}

class ItunesSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: SearchScreen(),
    );
  }
}
