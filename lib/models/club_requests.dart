import '../components/constants.dart';
import '../components/image_constants.dart';

class ClubRequest {
  late int _id;
  late int _requestorId;
  late String _imageUrl;
  late String _requestorName;
  late String _requestorEmail;

  ClubRequest(this._id, this._requestorId, this._requestorName, this._imageUrl,
      this._requestorEmail);

  factory ClubRequest.fromJson(dynamic json) {
    String imageUrl;
    if (json['requestorAvatarUrl'] != null &&
        (json['requestorAvatarUrl'] as String).isNotEmpty) {
      imageUrl = json['requestorAvatarUrl'] as String;
    } else {
      imageUrl = defaultCollectionImg;
    }
    return ClubRequest(
      json['id'] as int,
      json['requestorId'] as int,
      json['requestorName'] as String,
      imageUrl,
      json['requestorEmail'] as String,
    );
  }

  int getId() {
    return _id;
  }

  int getRequestorId() {
    return _requestorId;
  }

  String getImageUrl() {
    return _imageUrl;
  }

  String getName() {
    return _requestorName;
  }

  String getEmail() {
    return _requestorEmail;
  }
}

class ClubRequestList {
  List<ClubRequest> clubRequests = [];

  ClubRequestList(this.clubRequests);

  factory ClubRequestList.fromJson(dynamic json) {
    return ClubRequestList((json['clubRequests'] as List)
        .map((e) => ClubRequest.fromJson(e))
        .toList());
  }
}
