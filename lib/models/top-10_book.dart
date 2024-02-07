import '../components/image_constants.dart';
import 'book_review.dart';
import 'genre.dart';

class Top10BookInfo {
  late int _id;
  late String _title;
  late String _coverImageUrl;
  late String? _author;
  late int? _userRating;
  late String? _ageRestriction;
  late GenresList _genres;
  late BookReview? _bookReview;

  Top10BookInfo(this._id, this._title, this._coverImageUrl, this._author,
      this._userRating, this._ageRestriction, this._genres, this._bookReview);

  Top10BookInfo.light(this._id, this._title, this._coverImageUrl, this._author);

  factory Top10BookInfo.fromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    BookReview? bookReview;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    if (json['review'] != null) {
      bookReview = BookReview.top10fromJson(json['review']);
    }
    return Top10BookInfo(
        json['id'] as int,
        json['title'] as String,
        coverImageUrl,
        json['author'] as String?,
        json['userRating'] as int?,
        json['ageRestriction'] as String?,
        GenresList.fromJson(json),
        bookReview);
  }

  factory Top10BookInfo.lightFromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return Top10BookInfo.light(json['id'] as int, json['title'] as String,
        coverImageUrl, json['author'] as String?);
  }

  @override
  bool operator ==(Object other) => other is Top10BookInfo && _id == other._id;

  @override
  int get hashCode =>
      Object.hash(_id, _title, _author, _coverImageUrl);

  int getId() {
    return _id;
  }

  String getTitle() {
    return _title;
  }

  String getImageUrl() {
    return _coverImageUrl;
  }

  String? getAuthors() {
    return _author;
  }

  int? getUserRating() {
    return _userRating;
  }

  String? getAgeRest() {
    return _ageRestriction;
  }

  BookReview? getReview() {
    return _bookReview;
  }

  GenresList getGenreList() {
    return _genres;
  }
}

class Top10BookList {
  int userId;
  List<Top10BookInfo> allBooks = [];

  Top10BookList(this.allBooks, this.userId);

  factory Top10BookList.fromJson(dynamic json) {
    return Top10BookList(
      (json['booksTopDetailed'] as List)
          .map((e) => Top10BookInfo.fromJson(e))
          .toList(),
      json['userId'] as int,
    );
  }
}

class Top10BookListLight {
  int userId;
  List<Top10BookInfo> topBooks = [];

  Top10BookListLight(this.topBooks, this.userId);

  factory Top10BookListLight.fromJson(dynamic json) {
    return Top10BookListLight(
      (json['booksTop'] as List)
          .map((e) => Top10BookInfo.lightFromJson(e))
          .toList(),
      json['userId'] as int,
    );
  }
}
