class AchievementLevel {
  late String _postfix;
  late String _imageUrl;
  late int _number;
  late DateTime? _reachedAt;
  late int _goal;

  AchievementLevel(
      this._postfix, this._imageUrl, this._number, date, this._goal) {
    date != null ? _reachedAt = DateTime.parse(date) : _reachedAt = null;

  }

  factory AchievementLevel.fromJson(dynamic json) {
    return AchievementLevel(
      json['postfix'] as String,
      json['imageUrl'] as String,
      json['number'] as int,
      json['reachedAt'] as String?,
      json['goal'] as int,
    );
  }

  String getPrefix() {
    return _postfix;
  }

  String getImage() {
    return _imageUrl;
  }

  int getNumber() {
    return _number;
  }

  DateTime? getReachedDate() {
    return _reachedAt;
  }

  int getGoal() {
    return _goal;
  }
}
