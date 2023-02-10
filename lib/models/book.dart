import '../models/book_status.dart';

import '../components/constants.dart';
import 'genre.dart';

class Book {
  late int _id;
  late String _title;
  late List<String> _authors;
  late String _coverImageUrl;
  late GenresList _genres;
  late double _rating;
  late BookStatus _status;

  Book(this._id, this._title, this._authors, this._coverImageUrl, this._genres,
      this._rating, String strStatus) {
    _status = BookStatus.values
        .firstWhere((e) => e.toString() == "BookStatus." + strStatus);
  }

  factory Book.fromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return Book(
        json['id'] as int,
        json['title'] as String,
        (json['authors'] as List).map((e) => e as String).toList(),
        coverImageUrl,
        GenresList.fromJson(json),
        json['rating'].toDouble(),
        json['status'] as String);
  }

  String getTitle() {
    return _title;
  }

  String getImageUrl() {
    return _coverImageUrl;
  }

  List<String> getAuthors() {
    return _authors;
  }

  GenresList getGenreList() {
    return _genres;
  }

  double getRating() {
    return _rating;
  }

  BookStatus getStat() {
    return _status;
  }
}

class BookList {
  List<Book> foundBooks = [];

  BookList(this.foundBooks);

  factory BookList.fromJson(dynamic json) {
    return BookList(
        (json['books'] as List).map((e) => Book.fromJson(e)).toList());
  }
}
