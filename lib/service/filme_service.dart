
import 'dart:convert';

import 'package:flutter_movie/domain/filme.dart';
import 'package:http/http.dart' as http;

class FilmesService {

  static final url_image = "https://image.tmdb.org/t/p/w300/";


  static Future<List<Filme>> getFilmes() async {

    String api_key = "9ac4466dcf069ac63db44c560c9e8731";
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";


    final response = await http.get(url);

    print("FILMES ${response.body}");

    final mapFilmes = json.decode(response.body);

    List<Filme> filmes = mapFilmes['results'].map<Filme>((json) => Filme.fromJson(json)).toList();

    return filmes;

  }
}