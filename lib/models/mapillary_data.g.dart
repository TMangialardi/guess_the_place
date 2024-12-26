// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapillary_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapillaryData _$MapillaryDataFromJson(Map<String, dynamic> json) =>
    MapillaryData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MapillaryId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapillaryDataToJson(MapillaryData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MapillaryId _$MapillaryIdFromJson(Map<String, dynamic> json) => MapillaryId(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MapillaryIdToJson(MapillaryId instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
