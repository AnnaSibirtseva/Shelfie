import '../components/constants.dart';

class Collection {
  late int _id;
  late String _imageUrl;
  late String _name;
  late String _description;


  Collection(this._id, this._imageUrl, this._name, this._description);

  factory Collection.fromJson(dynamic json) {
    String imageUrl;
    String name;
    String description;
    if (json['imageUrl'] != null) {
      imageUrl = json['imageUrl'] as String;
    } else {
      imageUrl = defaultCollectionImg;
    }
    if (json['name'] != null) {
      name = json['name'] as String;
    } else {
      name = defaultCollectionName;
    }
    if (json['description'] != null) {
      description = json['description'] as String;
    } else {
      description = defaultCollectionDesc;
    }
    return Collection(
      json['id'] as int,
      imageUrl,
      name,
      description,
    );
  }

  String getImageUrl() {
    return _imageUrl;
  }

  String getName() {
    if (_name.length > 25) {
      return _name.substring(0, 25) + '...';
    }
    return _name;
  }

  String getDescription() {
    if (_description.length > 80) {
      return _description.substring(0, 80) + '...';
    }
    return _description;
  }
}

class RecommendedCollections {
  List<Collection> collections = [];

  RecommendedCollections(this.collections);

  factory RecommendedCollections.fromJson(dynamic json) {
    return RecommendedCollections(
        (json['collections'] as List).map((e) => Collection.fromJson(e)).toList());
  }
}