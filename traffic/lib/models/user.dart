
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  int age;
  String gender;
  String address;
  String username;
  String email;
  String password;
  String phone;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toSon() => _$UserToJson(this);
}
