class UserQuote {
  late int _bookId;
  late String _bookTitle;
  late String _bookCoverUrl;
  late List<String> _bookAuthors;
  late String _text;

  UserQuote(this._bookId, this._bookTitle, this._bookCoverUrl, this._bookAuthors, this._text);

  factory UserQuote.fromJson(dynamic json) {
    return UserQuote(
      json['bookId'] as int,
      json['bookTitle'] as String,
      json['bookCoverImageUrl'] as String,
      (json['bookAuthors'] as List).map((e) => e as String).toList(),
      json['text'] as String,
    );
  }

  String getQuoteText() {
    return _text;
  }

  String getAuthors() {
    if (_bookAuthors.isEmpty) {
      return '-';
    } else if (_bookAuthors.length == 1) {
      return _bookAuthors.first;
    }
    return _bookAuthors[0] + ', ' + _bookAuthors[1];
  }

  String getQuoteImg() {
    return _bookCoverUrl;
  }

  String getTitle() {
    return _bookTitle;
  }
}

class UserQuotesList {
  int count;
  List<UserQuote> quotes = [];

  UserQuotesList(this.quotes, this.count);

  factory UserQuotesList.fromJson(dynamic json) {
    return UserQuotesList(
      (json['quotes'] as List).map((e) => UserQuote.fromJson(e)).toList(),
      json['count'] as int,
    );
  }
}