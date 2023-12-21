// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      tokenType: json['tokenType'] as String,
      accessToken: json['accessToken'] as String,
      authorities: (json['authorities'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'tokenType': instance.tokenType,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'authorities': instance.authorities,
    };
