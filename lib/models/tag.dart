class ClubTag {
  late int _id;
  late String _tagName;

  ClubTag(this._id, this._tagName);

  factory ClubTag.fromJson(dynamic json) {
    return ClubTag(
      json['id'] as int,
      json['name'] as String,
    );
  }

  int getId() {
    return _id;
  }

  String getTagName() {
    return _tagName;
  }
}

class ClubTagList {
  List<ClubTag> tags = [];

  ClubTagList(this.tags);

  factory ClubTagList.fromJson(dynamic json) {
    return ClubTagList(
        (json['tags'] as List).map((e) => ClubTag.fromJson(e)).toList());
  }
}
