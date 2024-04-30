import '../components/image_constants.dart';
import 'book.dart';
import 'enums/event_status.dart';
import 'enums/user_event_status.dart';

class BookClubEvent {
  late int _id;
  late String _title;
  late String? _description;
  late String _place;
  late String _coverImageUrl;
  late Book? _bookInfo;
  late DateTime _date;
  late int _participantsAmount;
  late double? _rating;
  late EventStatus _eventStatus;
  late UserEventStatus _userParticipationStatus;
  late bool? _canBeEditedByUser;
  late bool _isPassed;
  late bool? _hasUserEventReview;
  late int _clubId;
  late String _clubName;
  late String _clubCoverImageUrl;

  BookClubEvent(
      this._id,
      this._title,
      this._description,
      this._place,
      this._coverImageUrl,
      this._bookInfo,
      date,
      this._participantsAmount,
      this._rating,
      this._canBeEditedByUser,
      this._isPassed,
      eventStatus,
      participationStatus) {
    _eventStatus = EventStatus.values
        .firstWhere((e) => e.toString() == "EventStatus." + eventStatus);
    participationStatus ??= "NotSet";
    _userParticipationStatus = UserEventStatus.values.firstWhere(
        (e) => e.toString() == "UserEventStatus." + participationStatus);
    _date = DateTime.parse(date);
  }

  BookClubEvent.forUser(
      this._id,
      this._title,
      this._place,
      this._coverImageUrl,
      this._bookInfo,
      date,
      this._participantsAmount,
      this._rating,
      this._canBeEditedByUser,
      this._isPassed,
      this._hasUserEventReview,
      eventStatus,
      participationStatus,
      this._clubId,
      this._clubName,
      this._clubCoverImageUrl) {
    _eventStatus = EventStatus.values
        .firstWhere((e) => e.toString() == "EventStatus." + eventStatus);
    participationStatus ??= "NotSet";
    _userParticipationStatus = UserEventStatus.values.firstWhere(
        (e) => e.toString() == "UserEventStatus." + participationStatus);
    _date = DateTime.parse(date);
  }

  factory BookClubEvent.fromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return BookClubEvent(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String?,
      json['place'] as String,
      coverImageUrl,
      json['bookInfo'] == null
          ? null
          : Book.eventInfoFromJson(json['bookInfo']),
      json['date'] as String,
      json['participantsAmount'] as int,
      json['rating']?.toDouble(),
      json['canBeEditedByUser'] as bool?,
      json['isPassed'] as bool,
      json['eventStatus'] as String,
      json['userParticipationStatus'] as String?,
    );
  }

  factory BookClubEvent.forUserFromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    String clubCoverImageUrl = defaultCollectionImg;
    if (json['clubCoverImageUrl'] != null) {
      clubCoverImageUrl = json['clubCoverImageUrl'] as String;
    }
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return BookClubEvent.forUser(
      json['id'] as int,
      json['title'] as String,
      json['place'] as String,
      coverImageUrl,
      json['bookInfo'] == null
          ? null
          : Book.eventInfoFromJson(json['bookInfo']),
      json['date'] as String,
      json['participantsAmount'] as int,
      json['rating']?.toDouble(),
      json['canBeEditedByUser'] as bool?,
      json['isPassed'] as bool,
      json['hasUserEventReview'] as bool?,
      json['eventStatus'] as String,
      json['userParticipationStatus'] as String?,
      json['clubId'] as int,
      json['clubName'] as String,
      clubCoverImageUrl,
    );
  }

  int getId() {
    return _id;
  }

  int getClubId() {
    return _clubId;
  }

  bool getHasUserEventReview() {
    if (_hasUserEventReview == null) {
      return false;
    }
    return _hasUserEventReview!;
  }

  String getClubName() {
    return _clubName;
  }

  String getClubImg() {
    return _clubCoverImageUrl;
  }

  String? getDesc() {
    return _description;
  }

  String getTitle() {
    return _title;
  }

  String getPlace() {
    return _place;
  }

  String getCoverImageUrl() {
    return _coverImageUrl;
  }

  DateTime getDate() {
    return _date;
  }

  Book? getBookInfo() {
    return _bookInfo;
  }

  int getParticipantsAmount() {
    return _participantsAmount;
  }

  double? getRating() {
    return _rating;
  }

  EventStatus getEventStatus() {
    return _eventStatus;
  }

  UserEventStatus getUserParticipationStatus() {
    return _userParticipationStatus;
  }

  bool getCanBeEditedByUser() {
    if (_canBeEditedByUser == null) {
      return false;
    }
    return _canBeEditedByUser!;
  }

  bool getIsPassed() {
    return _isPassed;
  }
}
