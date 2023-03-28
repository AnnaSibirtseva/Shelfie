import '../components/constants.dart';

class UserBook {
  late int _id;
  late String _title;
  late List<String> _authors;
  late String _coverImageUrl;
  late int? _userRating;
  late String? _startTime;
  late String? _endTime;

  UserBook(this._id, this._title, this._authors, this._coverImageUrl, this._userRating, this._startTime, this._endTime);

  factory UserBook.fromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return UserBook(
        json['id'] as int,
        json['title'] as String,
        (json['authors'] as List).map((e) => e as String).toList(),
        coverImageUrl,
        json['userRating'] as int?,
        json['startTime'] as String?,
        json['endTime'] as String?);
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

  int? getUserRating() {
    return _userRating;
  }

  String getStartTime() {
    return _startTime == null ? '-' : _startTime!;
  }

  String getEndTime() {
    return _endTime == null ? '-' : _endTime!;
  }
}

class UserBookList {
  int count;
  List<UserBook> allBooks = [];

  UserBookList(this.allBooks, this.count);

  factory UserBookList.fromJson(dynamic json) {
    return UserBookList(
        (json['books'] as List).map((e) => UserBook.fromJson(e)).toList(),
        json['count'] as int);
  }
}
