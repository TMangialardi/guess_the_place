// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['GUIDAccount', 'Username', 'Password'],
  );
  return Results(
    id: (json['id'] as num?)?.toInt(),
    order: json['order'] as String?,
    guidAccount: json['GUIDAccount'] as String?,
    username: json['Username'] as String?,
    password: json['Password'] as String?,
    personalRecord: json['PersonalRecord'] as String? ?? '-99999',
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'GUIDAccount': instance.guidAccount,
      'Username': instance.username,
      'Password': instance.password,
      'PersonalRecord': instance.personalRecord,
    };
