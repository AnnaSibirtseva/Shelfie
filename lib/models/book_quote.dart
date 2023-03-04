class BookQuote {
  late int _id;
  late String _quoteText;
  late bool _isSaved;

  BookQuote(this._id, this._quoteText, this._isSaved);

  factory BookQuote.fromJson(dynamic json) {
    return BookQuote(
      json['id'] as int,
      json['text'] as String,
      json['isSaved'] as bool,
    );
  }

  String getQuoteText() {
    return _quoteText;
  }

  bool isQuoteSaved() {
    return _isSaved;
  }

  void reverseQuoteSaved() {
    _isSaved = !_isSaved;
  }
}

class BookQuotesList {
  int count;
  List<BookQuote> quotes = [];

  BookQuotesList(this.quotes, this.count);

  factory BookQuotesList.fromJson(dynamic json) {
    return BookQuotesList(
      (json['quotes'] as List).map((e) => BookQuote.fromJson(e)).toList(),
      json['count'] as int,
    );
  }
}
