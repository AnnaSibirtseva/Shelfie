import '../components/constants.dart';

class Statistic {
  late int _bookCount;
  late int _reviewCount;
  late int _achievementCount;


  Statistic(this._bookCount, this._reviewCount, this._achievementCount);

  factory Statistic.fromJson(dynamic json) {
    return Statistic(
      json['bookCount'] as int,
      json['reviewCount'] as int,
      json['achievementCount'] as int,
    );
  }

  int getBookCount() {
    return _bookCount;
  }

  int getReviewCount() {
    return _reviewCount;
  }

  int getAchievementCount() {
    return _achievementCount;
  }

}