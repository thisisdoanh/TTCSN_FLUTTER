import 'package:json_annotation/json_annotation.dart';

import 'google_map_location.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location({
    required this.offices,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final Office offices;
}
