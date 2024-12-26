// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardData _$LeaderboardDataFromJson(Map<String, dynamic> json) =>
    LeaderboardData(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => LeaderboardResults.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaderboardDataToJson(LeaderboardData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

LeaderboardResults _$LeaderboardResultsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['Username'],
  );
  return LeaderboardResults(
    id: (json['id'] as num?)?.toInt(),
    order: json['order'] as String?,
    username: json['Username'] as String?,
    personalRecord: json['PersonalRecord'] as String? ?? '-99999',
  );
}

Map<String, dynamic> _$LeaderboardResultsToJson(LeaderboardResults instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'Username': instance.username,
      'PersonalRecord': instance.personalRecord,
    };
