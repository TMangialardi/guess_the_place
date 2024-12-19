import 'package:json_annotation/json_annotation.dart';

part 'mapillary_data.g.dart';

@JsonSerializable()
class MapillaryData {
  @JsonKey(name: 'data')
  List<MapillaryId>? data;

  MapillaryData({this.data});

  factory MapillaryData.fromJson(Map<String, dynamic> json) =>
      _$MapillaryDataFromJson(json);

  Map<String, dynamic> toJson(MapillaryData data) =>
      _$MapillaryDataToJson(data);
}

@JsonSerializable()
class MapillaryId {
  @JsonKey(name: 'id')
  String? id;

  MapillaryId({this.id});

  factory MapillaryId.fromJson(Map<String, dynamic> json) =>
      _$MapillaryIdFromJson(json);

  Map<String, dynamic> toJson(MapillaryId data) => _$MapillaryIdToJson(data);
}
