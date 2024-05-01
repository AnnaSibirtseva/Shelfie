class EventReview {
  late int _id;
  late String? _text;
  late double? _rating;
  late String _aliasName;
  late String _aliasAvatarUrl;

  late DateTime _createdAt;

  EventReview(this._id, this._text, this._rating, date, this._aliasName,
      this._aliasAvatarUrl) {
    _createdAt = DateTime.parse(date);
  }

  factory EventReview.fromJson(dynamic json) {
    return EventReview(
        json['id'] as int,
        json['text'] as String?,
        json['rating']?.toDouble(),
        json['createdAt'] as String,
        json['aliasName'] as String,
        json['aliasAvatarImageUrl'] as String);
  }

  int getId() {
    return _id;
  }

  String getRating() {
    if (_rating == null) {
      return "0";
    }
    return _rating!.toStringAsFixed(0);
  }

  String getAliasImageUrl() {
    return _aliasAvatarUrl;
  }

  String? getText() {
    return _text;
  }

  String getAliasName() {
    return _aliasName;
  }

  DateTime getCreatedDT() {
    return _createdAt;
  }
}
