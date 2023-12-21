import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  String tokenType;
  String accessToken;
  String refreshToken;
  List<Map<String, String>> authorities;

  Token({
    required this.tokenType,
    required this.accessToken,
    required this.authorities,
    required this.refreshToken,
  });
  factory Token.fromJson(Map<String, dynamic> json) =>
      _$TokenFromJson(json);
  Map<String, dynamic> toSon() => _$TokenToJson(this);
}
