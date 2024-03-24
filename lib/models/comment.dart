import '../components/constants.dart';
import '../components/image_constants.dart';

class Comment {
  late int _id;
  late String _text;
  late DateTime _createdAt;
  late int _userId;
  late String _userName;
  late String _userAvatarUrl;
  late bool _canBeDeletedByUser;
  late bool _canBeEditedByUser;

  Comment(this._id, this._text, date, this._userId, this._userName,
      this._userAvatarUrl, this._canBeDeletedByUser, this._canBeEditedByUser) {
    _createdAt = DateTime.parse(date);
  }

  factory Comment.fromJson(dynamic json) {
    String imageUrl;
    if (json['userAvatarUrl'] != null &&
        (json['userAvatarUrl'] as String).isNotEmpty) {
      imageUrl = json['userAvatarUrl'] as String;
    } else {
      imageUrl = defaultCollectionImg;
    }
    return Comment(
      json['id'] as int,
      json['text'] as String,
      json['createdAt'] as String,
      json['userId'] as int,
      json['userName'] as String,
      imageUrl,
      json['canBeDeletedByUser'] as bool,
      json['canBeEditedByUser'] as bool,
    );
  }

  int getId() {
    return _id;
  }

  String getImageUrl() {
    return _userAvatarUrl;
  }

  String getText() {
    return _text;
  }

  String getUserName() {
    return _userName;
  }

  int getUserId() {
    return _userId;
  }

  bool getCanBeEditedByUser() {
    return _canBeEditedByUser;
  }

  bool getCanBeDeletedByUser() {
    return _canBeDeletedByUser;
  }

  DateTime getCreatedDT() {
    return _createdAt;
  }
}
