import '../models/book_status.dart';

import '../components/constants.dart';
import 'book_stat.dart';
import 'genre.dart';

class Book {
  late int _id;
  late String _title;
  late List<String> _authors;
  late String _coverImageUrl;
  late GenresList _genres;
  late double? _rating;
  late int? _userRating;
  late BookStatus _status;
  late String? _description;
  late String? _language;
  late String? _ageRestriction;
  late BookStatistic _statistics;

  Book(this._id, this._title, this._authors, this._coverImageUrl, this._genres,
      this._rating, this._userRating, String strStatus) {
    _status = BookStatus.values
        .firstWhere((e) => e.toString() == "BookStatus." + strStatus);
  }

  Book.allInfo(
      this._id,
      this._title,
      this._coverImageUrl,
      this._authors,
      this._userRating,
      this._rating,
      this._genres,
      this._language,
      this._ageRestriction,
      this._statistics,
      this._description,
      String strStatus) {
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
        json['averageRating']?.toDouble(),
        json['userRating'] as int?,
        json['status'] as String);
  }

  factory Book.allInfoFromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return Book.allInfo(
        json['id'] as int,
        json['title'] as String,
        coverImageUrl,
        (json['authors'] as List).map((e) => e as String).toList(),
        json['userRating'] as int?,
        json['averageRating']?.toDouble(),
        GenresList.fromJson(json),
        json['language'] as String?,
        json['ageRestriction'] as String?,
        BookStatistic.fromJson(json['statistics']),
        json['description'] as String?,
        json['status'] as String);
  }

  int getId() {
    return _id;
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

  double? getRating() {
    if (_rating != null) {
      return double.parse((_rating!).toStringAsFixed(2));
    }
    return _rating;
  }

  BookStatus getStatus() {
    return _status;
  }

  int? getUserRating() {
    return _userRating;
  }

  String? getDesc() {
    return _description;
  }

  String? getLanguage() {
    return _language;
  }

  String? getAgeRest() {
    return _ageRestriction;
  }

  BookStatistic getStatistics() {
    return _statistics;
  }
}

class BookList {
  int count;
  List<Book> foundBooks = [];

  BookList(this.foundBooks, this.count);

  factory BookList.fromJson(dynamic json) {
    return BookList(
        (json['books'] as List).map((e) => Book.fromJson(e)).toList(),
        json['count'] as int);
  }
}
