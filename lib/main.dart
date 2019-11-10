import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/filmes_page.dart';
import 'package:flutter_movie/pages/login_page.dart';
import 'package:flutter_movie/utils/nav.dart';
import 'package:flutter_movie/utils/prefs.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  verifyLogin(context) async {
    String s = await Prefs.getString("logged");
    if (s != null || s.isNotEmpty) {
      pushReplacement(context, FilmesPage());
    }
  }
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

