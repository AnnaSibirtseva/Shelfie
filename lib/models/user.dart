import 'package:shelfie/models/statistic.dart';

import '../components/constants.dart';

class User {
  late int _id;
  late String _name;
  late String _email;
  late String _profileImageUrl;
  late String _bannerImageUrl;
  late Statistic _statistics;

  User(this._name, this._email, this._profileImageUrl, this._bannerImageUrl,
      this._statistics);

  User.idInfo(this._id);

  User.userInfo(this._id, this._name, this._profileImageUrl);

  factory User.userIdFromJson(dynamic json) {
    return User.idInfo(
      json['userId'] as int,
    );
  }

  factory User.userInfoFromJson(dynamic json) {
    String profileImageUrl;
    if (json['profileImageUrl'] != null) {
      profileImageUrl = json['profileImageUrl'] as String;
    } else {
      profileImageUrl = defaultCollectionImg;
    }
    return User.userInfo(
      json['id'] as int,
      json['name'] as String,
      profileImageUrl,
    );
  }

  factory User.fromJson(dynamic json) {
    String profileImageUrl;
    String bannerImageUrl;

    // todo: find default pick for profile and banner.
    if (json['profileImageUrl'] != null) {
      profileImageUrl = json['profileImageUrl'] as String;
    } else {
      profileImageUrl = defaultCollectionImg;
    }
    if (json['bannerImageUrl'] != null) {
      bannerImageUrl = json['bannerImageUrl'] as String;
    } else {
      bannerImageUrl = defaultCollectionDesc;
    }
    return User(
      json['name'] as String,
      json['email'] as String,
      profileImageUrl,
      bannerImageUrl,
      Statistic.fromJson(json['statistics']),
    );
  }

  String getProfileImageUrl() {
    return _profileImageUrl;
  }

  void setId(int id) {
    _id = id;
  }

  int getId() {
    return _id;
  }

  String getBannerImageUrl() {
    return _bannerImageUrl;
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  Statistic getStatistics() {
    return _statistics;
  }
}
