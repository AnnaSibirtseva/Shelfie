import '../components/constants.dart';
import 'book.dart';
import 'enums/event_status.dart';

class BookClubEvent {
  late int _id;
  late String _title;
  late String _place;
  late String _coverImageUrl;
  late Book _bookInfo;
  late String _date;
  late int _participantsAmount;
  late EventStatus _eventStatus;
  late String? _userParticipationStatus;
  late bool _canBeEditedByUser;
  late bool _isPassed;

  BookClubEvent(
      this._id,
      this._title,
      this._place,
      this._coverImageUrl,
      this._bookInfo,
      this._date,
      this._participantsAmount,
      this._userParticipationStatus,
      this._canBeEditedByUser,
      this._isPassed,
      strStatus) {
    _eventStatus = EventStatus.values
        .firstWhere((e) => e.toString() == "EventStatus." + strStatus);
  }

  factory BookClubEvent.fromJson(dynamic json) {
    String coverImageUrl = defaultBookCoverImg;
    if (json['coverImageUrl'] != null) {
      coverImageUrl = json['coverImageUrl'] as String;
    }
    return BookClubEvent(
        json['id'] as int,
        json['title'] as String,
        json['place'] as String,
        coverImageUrl,
        Book.eventInfoFromJson(json['bookInfo']),
        json['date'] as String,
        json['participantsAmount'] as int,
        json['userParticipationStatus'] as String?,
        json['canBeEditedByUser'] as bool,
        json['isPassed'] as bool,
        json['eventStatus'] as String);
  }

  int getId() {
    return _id;
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

  String getDate() {
    return _date;
  }

  Book getBookInfo() {
    return _bookInfo;
  }

  int getParticipantsAmount() {
    return _participantsAmount;
  }

  EventStatus getEventStatus() {
    return _eventStatus;
  }

  String? getUserParticipationStatus() {
    return _userParticipationStatus;
  }

  bool getCanBeEditedByUser() {
    return _canBeEditedByUser;
  }

  bool getIsPassed() {
    return _isPassed;
  }
}
