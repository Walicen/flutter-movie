import 'dart:convert';

class Filme {
  int id;
  String title;
  String name; //Series
  String posterPath;
  String overview;
  String backdropPath;
  String voteAverage;
  String releaseDate;
  String firstAirDate;
  List<dynamic> genreIds;

  Filme(
      this.id,
      this.title,
      this.name,
      this.posterPath,
      this.overview,
      this.backdropPath,
      this.voteAverage,
      this.releaseDate,
      this.firstAirDate,
      this.genreIds);

  Filme.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        name = map["name"],
        posterPath = map["poster_path"],
        overview = map["overview"],
        backdropPath = map["backdrop_path"],
        voteAverage = map["vote_average"].toString(),
        releaseDate = map["release_date"],
        firstAirDate = map["first_air_date"],
        genreIds = map["genre_ids"];

  toMap() {
    return {
      "id": id,
      "title": title,
      "name": name,
      "poster_path": posterPath,
      "overview": overview,
      "backdrop_path": backdropPath,
      "vote_average": voteAverage,
      "release_date": releaseDate,
      "first_air_date": firstAirDate,
      "genre_ids": genreIds,
    };
  }

  toJson() {
    return json.encode(toMap());
  }
}
