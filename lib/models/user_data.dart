import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<Results>? results;

  UserData({this.count, this.next, this.previous, this.results});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson(UserData instance) => _$UserDataToJson(instance);
}

@JsonSerializable()
class Results {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'order')
  String? order;
  @JsonKey(name: 'GUIDAccount', required: true)
  String? guidAccount;
  @JsonKey(name: 'Username', required: true)
  String? username;
  @JsonKey(name: 'Password', required: true)
  String? password;
  @JsonKey(name: 'PersonalRecord', required: false, defaultValue: "-99999")
  String? personalRecord;

  Results(
      {this.id,
      this.order,
      this.guidAccount,
      this.username,
      this.password,
      this.personalRecord});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson(Results instance) => _$ResultsToJson(instance);
}
