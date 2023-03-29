class Statistic {
  late int _bookCount;
  late int _reviewCount;
  late int _quoteCountCount;

  Statistic(this._bookCount, this._reviewCount, this._quoteCountCount);

  factory Statistic.fromJson(dynamic json) {
    return Statistic(
      json['bookCount'] as int,
      json['reviewCount'] as int,
      json['quoteCount'] as int,
    );
  }

  int getBookCount() {
    return _bookCount;
  }

  int getReviewCount() {
    return _reviewCount;
  }

  int getQuoteCount() {
    return _quoteCountCount;
  }
}
