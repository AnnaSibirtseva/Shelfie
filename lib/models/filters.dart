import '../models/tag.dart';

class Filters {
  List<String> languages = [];
  List<String> genres = [];
  List<String> ageRestrictions = [];

  Filters(this.languages, this.genres, this.ageRestrictions);

  factory Filters.fromJson(dynamic json) {
    return Filters(
        (json['languages'] as List).map((e) => e as String).toList(),
        (json['genres'] as List).map((e) => e as String).toList(),
        (json['ageRestrictions'] as List).map((e) => e as String).toList());
  }
}

class BookClubFilters {
  List<ClubTag> tags = [];

  BookClubFilters(this.tags);

  factory BookClubFilters.fromJson(dynamic json) {
    return BookClubFilters(ClubTagList.fromJson(json).tags);
  }
}
