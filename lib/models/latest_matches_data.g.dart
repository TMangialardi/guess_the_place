// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_matches_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestMatchesData _$LatestMatchesDataFromJson(Map<String, dynamic> json) =>
    LatestMatchesData(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MatchResults.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LatestMatchesDataToJson(LatestMatchesData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

MatchResults _$MatchResultsFromJson(Map<String, dynamic> json) => MatchResults(
      id: (json['id'] as num?)?.toInt(),
      order: json['order'] as String?,
      identifier: json['ID'] as String?,
      arcadeName: json['ArcadeName'] as String?,
      dateTime: json['DateTime'] as String?,
      matchLat: json['MatchLat'] as String?,
      matchLon: json['MatchLon'] as String?,
      guessedLat: json['GuessedLat'] as String?,
      guessedLon: json['GuessedLon'] as String?,
      points: json['Points'] as String?,
    );

Map<String, dynamic> _$MatchResultsToJson(MatchResults instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'ID': instance.identifier,
      'ArcadeName': instance.arcadeName,
      'DateTime': instance.dateTime,
      'MatchLat': instance.matchLat,
      'MatchLon': instance.matchLon,
      'GuessedLat': instance.guessedLat,
      'GuessedLon': instance.guessedLon,
      'Points': instance.points,
    };
