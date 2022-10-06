import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class UserEntity {
  String? name;
  int? id;
  @JsonKey(name: "is_log")
  bool? isLog;
  UserEntity({this.id, this.name, this.isLog});
  // from json
  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
