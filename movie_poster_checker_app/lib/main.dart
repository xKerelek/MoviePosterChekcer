import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MoviePosterCheckerApp());
}

class MoviePosterCheckerApp extends StatelessWidget {
  const MoviePosterCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie Poster Checker",
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
