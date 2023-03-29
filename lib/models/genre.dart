class Genre {
  late int _id;
  late String _genreName;

  Genre(this._id, this._genreName);

  factory Genre.fromJson(dynamic json) {
    return Genre(
      json['id'] as int,
      json['name'] as String,
    );
  }

  int getId() {
    return _id;
  }

  String getGenreName() {
    return _genreName;
  }
}

class GenresList {
  List<Genre> genres = [];

  GenresList(this.genres);

  factory GenresList.fromJson(dynamic json) {
    return GenresList(
        (json['genres'] as List).map((e) => Genre.fromJson(e)).toList());
  }
}
