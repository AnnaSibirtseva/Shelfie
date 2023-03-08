import '../components/constants.dart';
import 'package:flutter/material.dart';

class BookStatistic {
  late String _readingTime;
  late int _readCount;

  BookStatistic(this._readingTime, this._readCount);

  factory BookStatistic.fromJson(dynamic json) {
    return BookStatistic(
      json['readingTime'] as String,
      json['reviewCount'] as int,
    );
  }

  String getBookCount() {
    return _readingTime;
  }

  int getReviewCount() {
    return _readCount;
  }
}