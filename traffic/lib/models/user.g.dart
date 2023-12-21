// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      project: json['project'] == null
          ? null
          : IdProjectUser.fromJson(json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'project': instance.project,
    };
