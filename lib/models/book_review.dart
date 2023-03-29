import 'user.dart';

class BookReview {
  late int _id;
  late User _reviewAuthor;
  late String _reviewText;
  late String _reviewTitle;
  late double _rating;

  BookReview(this._id, this._reviewAuthor, this._reviewText, this._reviewTitle,
      this._rating);

  factory BookReview.fromJson(dynamic json) {
    return BookReview(
      json['id'] as int,
      User.userInfoFromJson(json['userInfo']),
      json['reviewText'] as String,
      json['reviewTitle'] as String,
      json['rating'].toDouble(),
    );
  }

  int getId() {
    return _id;
  }

  String getReviewTitle() {
    return _reviewTitle;
  }

  String getReviewText() {
    return _reviewText;
  }

  double getReviewRating() {
    return _rating;
  }

  User getReviewAuthor() {
    return _reviewAuthor;
  }
}

class BookReviewList {
  int count;
  List<BookReview> reviews = [];

  BookReviewList(this.reviews, this.count);

  factory BookReviewList.fromJson(dynamic json) {
    return BookReviewList(
      (json['reviews'] as List).map((e) => BookReview.fromJson(e)).toList(),
      json['count'] as int,
    );
  }
}
