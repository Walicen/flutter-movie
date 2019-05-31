import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/login_page.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.dark(),
        home: LoginPage()
    );
  }
}

