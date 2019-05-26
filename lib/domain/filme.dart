import 'dart:convert';

class Filme {

  String title;
  String poster_path;
  String overview;
  String backdrop_path;

  Filme(this.title, this.poster_path, this.overview, this.backdrop_path);

  Filme.fromJson(Map<String,dynamic> map):
        title = map["title"],
        poster_path = map["poster_path"],
        overview = map["overview"],
        backdrop_path = map["backdrop_path"];

  toMap() {
    return {
      "title": title,
      "poster_path": poster_path,
      "overview": overview,
      "backdrop_path": backdrop_path,
    };
  }

  toJson() {
    return json.encode(toMap());
  }
  
}