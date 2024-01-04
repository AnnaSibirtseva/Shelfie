class BookClub {
  late int _id;
  late String _name;
  late String? _description;
  late String _coverImageUrl;
  late bool _isPublic;
  late int _membersCount;
  late bool _isUserInClub;
  late List<String> _tags;

  BookClub.light(this._id, this._name, this._description, this._coverImageUrl,
      this._isPublic, this._membersCount, this._isUserInClub) {}

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
}
