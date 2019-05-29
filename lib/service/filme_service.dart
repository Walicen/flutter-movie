import 'dart:convert';

import 'package:flutter_movie/domain/filme.dart';
import 'package:http/http.dart' as http;

class FilmesService {
  static final url_image = "https://image.tmdb.org/t/p/w500/";

  static Future<List<Filme>> getFilmes(tipo) async {
    String url;

    String api_key = "9ac4466dcf069ac63db44c560c9e8731";
    if (tipo == 'serie') {
      url =
          "https://api.themoviedb.org/3/tv/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";
    } else {
      url =
          "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";
    }
//    String url = "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";

    final response = await http.get(url);

    print("FILMES ${response.body}");

    final mapFilmes = json.decode(response.body);

    List<Filme> filmes = mapFilmes['results']
        .map<Filme>((json) => Filme.fromJson(json))
        .toList();

    return filmes;
  }

  static getGenre(id) {
    var genres = [
      {"id": 12, "name": "Aventura"},
      {"id": 16, "name": "Animação"},
      {"id": 28, "name": "Ação"},
      {"id": 35, "name": "Comédia"},
      {"id": 37, "name": "Faroeste"},
      {"id": 80, "name": "Crime"},
      {"id": 99, "name": "Documentário"},
      {"id": 18, "name": "Drama"},
      {"id": 14, "name": "Fantasia"},
      {"id": 36, "name": "História"},
      {"id": 27, "name": "Terror"},
      {"id": 53, "name": "Thriller"},
      {"id": 37, "name": "Faroeste"},
      {"id": 878, "name": "Ficção científica"},
      {"id": 9648, "name": "Mistério"},
      {"id": 10402, "name": "Música"},
      {"id": 10749, "name": "Romance"},
      {"id": 10751, "name": "Família"},
      {"id": 10752, "name": "Guerra"},
      {"id": 10759, "name": "Action & Adventure"},
      {"id": 10762, "name": "Kids"},
      {"id": 10763, "name": "News"},
      {"id": 10764, "name": "Reality"},
      {"id": 10765, "name": "Sci-Fi & Fantasy"},
      {"id": 10766, "name": "Soap"},
      {"id": 10767, "name": "Talk"},
      {"id": 10768, "name": "War & Politics"},
      {"id": 10770, "name": "Cinema TV"},
    ];
    for (var i in genres) {
      if (i['id'] == id) {
        return i['name'];
      }
    }
  }

  static Future<List<Filme>> getSeries() async {
    String api_key = "9ac4466dcf069ac63db44c560c9e8731";
    String url =
        "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";
    final response = await http.get(url);

    print("FILMES ${response.body}");

    final mapFilmes = json.decode(response.body);

    List<Filme> filmes = mapFilmes['results']
        .map<Filme>((json) => Filme.fromJson(json))
        .toList();

    return filmes;
  }
}
