import 'package:shelfie/models/statistic.dart';

import '../components/constants.dart';

class User {
  late int _id;
  late String _name;
  late String _email;
  late String _profileImageUrl;
  late String _bannerImageUrl;
  late List<Statistic> _statistics;

  User(this._name, this._email, this._profileImageUrl,
      this._bannerImageUrl, this._statistics);

  User.byId(this._id);

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
      [],
    );
  }

  String getProfileImageUrl() {
    return _profileImageUrl;
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
}
