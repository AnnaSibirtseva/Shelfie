import 'package:shelfie_diploma_app/components/constants.dart';
import 'package:shelfie_diploma_app/models/parser.dart';
import 'package:shelfie_diploma_app/models/tag.dart';

class BookClub {
  late int _id;
  late String _name;
  late String? _description;
  late String _coverImageUrl;
  late bool _isPublic;
  late int _membersCount;
  late bool _isUserInClub;
  late ClubTagList _tags;

  BookClub.light(this._id, this._name, this._coverImageUrl, this._isPublic,
      this._membersCount, this._isUserInClub, this._tags) {}

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

  void setImgDefault() {
    _coverImageUrl = defaultCollectionImg;
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
