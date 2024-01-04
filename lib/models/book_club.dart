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

  BookClub.light(this._id, this._name, this._coverImageUrl,
      this._isPublic, this._membersCount, this._isUserInClub, this._tags) {}

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
