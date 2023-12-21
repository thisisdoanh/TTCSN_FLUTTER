import 'package:json_annotation/json_annotation.dart';
import 'package:traffic/models/project_detail.dart';

import 'id_project_user.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  int age;
  String? gender;
  String? address;
  String username;
  String email;
  String? phone;
  IdProjectUser? project;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.username,
    required this.email,
    required this.phone,
    required this.project,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toSon() => _$UserToJson(this);
}
