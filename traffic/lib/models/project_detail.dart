import 'package:json_annotation/json_annotation.dart';
import 'package:traffic/models/user.dart';

part 'project_detail.g.dart';

@JsonSerializable()
class ProjectDetail {
  int id;
  String name;
  String material;
  double budget;
  String description;
  DateTime startday;
  DateTime deadline;
  String? status;
  List<User?>? people;
  List<ProjectDetail?>? projects;

  ProjectDetail({
    required this.id,
    required this.name,
    required this.material,
    required this.budget,
    required this.description,
    required this.startday,
    required this.deadline,
    required this.projects,
    required this.people,
    required this.status,
  });
  factory ProjectDetail.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailFromJson(json);
  Map<String, dynamic> toSon() => _$ProjectDetailToJson(this);
}
