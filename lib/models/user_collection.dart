class UserCollection {
  late int _id;
  late String _name;
  late bool _isInCollection;

  UserCollection(this._id, this._name, this._isInCollection);

  factory UserCollection.fromJson(dynamic json) {
    return UserCollection(json['id'] as int, json['name'] as String,
        json['isInCollection'] as bool);
  }

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  bool getIsInCollection() {
    return _isInCollection;
  }
}

class UserCollectionList {
  List<UserCollection> allCollections = [];

  UserCollectionList(this.allCollections);

  factory UserCollectionList.fromJson(dynamic json) {
    return UserCollectionList((json['collections'] as List)
        .map((e) => UserCollection.fromJson(e))
        .toList());
  }
}
