import 'achivment_level.dart';

class Achievement {
  late int _id;
  late String _name;
  late String _desc;
  late int _curValue;
  late AchievementLevel _level;

  Achievement(this._id, this._name, this._desc, this._curValue, this._level);

  factory Achievement.fromJson(dynamic json) {
    return Achievement(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['currentValue'] as int,
      AchievementLevel.fromJson(json['levelInfo']),
    );
  }

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  String getDesc() {
    return _desc;
  }

  int getCurValue() {
    return _curValue;
  }

  AchievementLevel getLevelInfo() {
    return _level;
  }
}
