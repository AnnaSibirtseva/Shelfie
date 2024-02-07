import 'package:shelfie_diploma_app/models/parser.dart';
import 'package:shelfie_diploma_app/models/tag.dart';

import '../components/image_constants.dart';

class BookClub {
  late int _id;
  late String _name;
  late String? _description;
  late String _coverImageUrl;
  late String _bannerImageUrl;
  late bool _isPublic;
  late int _membersCount;
  late bool _isUserInClub;
  late bool _isUserAdminInClub;
  late ClubTagList _tags;

  BookClub.light(this._id, this._name, this._coverImageUrl, this._isPublic,
      this._membersCount, this._isUserInClub, this._tags) {}

  BookClub(
      this._id,
      this._name,
      this._description,
      this._coverImageUrl,
      this._bannerImageUrl,
      this._isPublic,
      this._membersCount,
      this._isUserInClub,
      this._isUserAdminInClub,
      this._tags) {}

  factory BookClub.lightFromJson(dynamic json) {
    String coverImageUrl = defaultCollectionImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = getImage(json['coverImageUrl'] as String);
    }
    return BookClub.light(
      json['id'] as int,
      json['name'] as String,
      coverImageUrl,
      json['isPublic'] as bool,
      json['membersAmount'] as int,
      json['isUserInClub'] as bool,
      ClubTagList.fromJson(json),
    );
  }

  factory BookClub.fromJson(dynamic json) {
    String coverImageUrl = defaultCollectionImg;
    String bannerImageUrl = defaultCollectionImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = getImage(json['coverImageUrl'] as String);
    }
    if (json['bannerImageUrl'] != null) {
      bannerImageUrl = getImage(json['bannerImageUrl'] as String);
    }
    return BookClub(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String?,
      coverImageUrl,
      bannerImageUrl,
      json['isPublic'] as bool,
      json['membersAmount'] as int,
      json['isUserInClub'] as bool,
      json['isUserAdminInClub'] as bool,
      ClubTagList.fromJson(json),
    );
  }

  void setImgDefault() {
    _coverImageUrl = defaultCollectionImg;
  }

  bool getIsUserAdminInClub() {
    return _isUserAdminInClub;
  }

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  String? getDescription() {
    return _description;
  }

  String getCoverImgUrl() {
    return _coverImageUrl;
  }

  String getBannerImgUrl() {
    return _bannerImageUrl;
  }

  bool isPublic() {
    return _isPublic;
  }

  int getMembersCount() {
    return _membersCount;
  }

  bool isUserInClub() {
    return _isUserInClub;
  }

  ClubTagList getClubTags() {
    return _tags;
  }
}

class BookClubsList {
  List<BookClub> clubs = [];
  int count;

  BookClubsList(this.clubs, this.count);

  factory BookClubsList.fromJson(dynamic json) {
    return BookClubsList(
        (json['clubs'] as List).map((e) => BookClub.lightFromJson(e)).toList(),
        json['count'] as int);
  }
}
