import '../components/constants.dart';
import '../components/image_constants.dart';

class ClubMember {
  late int _userId;
  late int _memberId;
  late String _avatarUrl;
  late String _name;
  late String _email;
  late bool _hasAdminRules;

  ClubMember(this._userId, this._memberId, this._name, this._avatarUrl,
      this._email, this._hasAdminRules);

  factory ClubMember.fromJson(dynamic json) {
    String imageUrl;
    if (json['avatarUrl'] != null && (json['avatarUrl'] as String).isNotEmpty) {
      imageUrl = json['avatarUrl'] as String;
    } else {
      imageUrl = defaultCollectionImg;
    }
    return ClubMember(
      json['userId'] as int,
      json['memberId'] as int,
      json['name'] as String,
      imageUrl,
      json['email'] as String,
      json['hasAdminRules'] as bool,
    );
  }

  int getId() {
    return _userId;
  }

  int getRequestorId() {
    return _memberId;
  }

  String getImageUrl() {
    return _avatarUrl;
  }

  bool getHasAdminRules() {
    return _hasAdminRules;
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }
}
