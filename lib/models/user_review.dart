class UserReview {
  late int _id;
  late int _bookId;
  late String _bookTitle;
  late String _bookCoverUrl;
  late List<String> _bookAuthors;
  late String _text;
  late double _rating;

  UserReview(this._id, this._bookId, this._bookTitle, this._bookCoverUrl, this._bookAuthors, this._text, this._rating);

  factory UserReview.fromJson(dynamic json) {
    String reviewText = '-';
    if ( json['reviewText'] != null) {
      reviewText = json['reviewText'] as String;
    }
    return UserReview(
      json['id'] as int,
      json['bookId'] as int,
      json['bookTitle'] as String,
      json['bookCoverImageUrl'] as String,
      (json['bookAuthors'] as List).map((e) => e as String).toList(),
      reviewText,
      json['rating'].toDouble(),
    );
  }

  int getId() {
    return _id;
  }

  String getReviewText() {
    return _text;
  }

  double getReviewRating() {
    return _rating;
  }

  String getAuthors() {
    if (_bookAuthors.isEmpty) {
      return '-';
    } else if (_bookAuthors.length == 1) {
      return _bookAuthors.first;
    }
    return _bookAuthors[0] + ', ' + _bookAuthors[1];
  }

  String getReviewImg() {
    return _bookCoverUrl;
  }

  String getTitle() {
    return _bookTitle;
  }
}

class UserReviewsList {
  int count;
  List<UserReview> reviews = [];

  UserReviewsList(this.reviews, this.count);

  factory UserReviewsList.fromJson(dynamic json) {
    return UserReviewsList(
      (json['reviews'] as List).map((e) => UserReview.fromJson(e)).toList(),
      json['count'] as int,
    );
  }
}
