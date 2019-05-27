import 'dart:convert';

class Filme {

  String title;
  String name; //Series
  String poster_path;
  String overview;
  String backdrop_path;

  Filme(this.title, this.name, this.poster_path, this.overview, this.backdrop_path);

  Filme.fromJson(Map<String,dynamic> map):
        title = map["title"],
        name = map["name"],
        poster_path = map["poster_path"],
        overview = map["overview"],
        backdrop_path = map["backdrop_path"];

  toMap() {
    return {
      "title": title,
      "name": name,
      "poster_path": poster_path,
      "overview": overview,
      "backdrop_path": backdrop_path,
    };
  }

  toJson() {
    return json.encode(toMap());
  }
  
}