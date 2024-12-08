import 'package:json_annotation/json_annotation.dart';

part 'latest_matches_data.g.dart';

@JsonSerializable()
class LatestMatchesData {
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<MatchResults>? results;

  LatestMatchesData({this.count, this.next, this.previous, this.results});

  factory LatestMatchesData.fromJson(Map<String, dynamic> json) =>
      _$LatestMatchesDataFromJson(json);

  Map<String, dynamic> toJson(LatestMatchesData data) =>
      _$LatestMatchesDataToJson(data);
}

@JsonSerializable()
class MatchResults {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'order')
  String? order;
  @JsonKey(name: 'ID')
  String? identifier;
  @JsonKey(name: 'ArcadeName')
  String? arcadeName;
  @JsonKey(name: 'DteTime')
  String? dateTime;
  @JsonKey(name: 'MatchLat')
  String? matchLat;
  @JsonKey(name: 'MatchLon')
  String? matchLon;
  @JsonKey(name: 'GuessedLat')
  String? guessedLat;
  @JsonKey(name: 'GuessedLon')
  String? guessedLon;
  @JsonKey(name: 'Points')
  String? points;

  MatchResults(
      {this.id,
      this.order,
      this.identifier,
      this.arcadeName,
      this.dateTime,
      this.matchLat,
      this.matchLon,
      this.guessedLat,
      this.guessedLon,
      this.points});

  factory MatchResults.fromJson(Map<String, dynamic> json) =>
      _$MatchResultsFromJson(json);

  Map<String, dynamic> toJson(MatchResults data) => _$MatchResultsToJson(data);
}
