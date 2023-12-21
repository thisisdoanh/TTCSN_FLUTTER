import 'package:json_annotation/json_annotation.dart';

part 'id_project_user.g.dart';

@JsonSerializable()
class IdProjectUser {
  int id;

  IdProjectUser({
    required this.id,
  });
  factory IdProjectUser.fromJson(Map<String, dynamic> json) =>
      _$IdProjectUserFromJson(json);
  Map<String, dynamic> toSon() => _$IdProjectUserToJson(this);
}
