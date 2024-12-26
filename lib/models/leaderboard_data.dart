import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_data.g.dart';

@JsonSerializable()
class LeaderboardData {
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<LeaderboardResults>? results;

  LeaderboardData({this.count, this.next, this.previous, this.results});

  factory LeaderboardData.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardDataFromJson(json);

  Map<String, dynamic> toJson(LeaderboardData instance) =>
      _$LeaderboardDataToJson(instance);
}

@JsonSerializable()
class LeaderboardResults {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'order')
  String? order;
  @JsonKey(name: 'Username', required: true)
  String? username;
  @JsonKey(name: 'PersonalRecord', required: false, defaultValue: "-99999")
  String? personalRecord;

  LeaderboardResults({this.id, this.order, this.username, this.personalRecord});

  factory LeaderboardResults.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardResultsFromJson(json);

  Map<String, dynamic> toJson(LeaderboardResults instance) =>
      _$LeaderboardResultsToJson(instance);
}
