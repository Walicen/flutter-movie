import 'dart:convert';

class Filme {
  int id;
  String title;
  String name; //Series
  String poster_path;
  String overview;
  String backdrop_path;
  String vote_average;
  String release_date;
  String first_air_date;
  List<dynamic> genre_ids;

  Filme(
      this.id,
      this.title,
      this.name,
      this.poster_path,
      this.overview,
      this.backdrop_path,
      this.vote_average,
      this.release_date,
      this.first_air_date,
      this.genre_ids);

  Filme.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        name = map["name"],
        poster_path = map["poster_path"],
        overview = map["overview"],
        backdrop_path = map["backdrop_path"],
        vote_average = map["vote_average"].toString(),
        release_date = map["release_date"],
        first_air_date = map["first_air_date"],
        genre_ids = map["genre_ids"];

  toMap() {
    return {
      "id": id,
      "title": title,
      "name": name,
      "poster_path": poster_path,
      "overview": overview,
      "backdrop_path": backdrop_path,
      "vote_average": vote_average,
      "release_date": release_date,
      "first_air_date": first_air_date,
      "genre_ids": genre_ids,
    };
  }

  toJson() {
    return json.encode(toMap());
  }
}
