// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDetail _$ProjectDetailFromJson(Map<String, dynamic> json) =>
    ProjectDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      material: json['material'] as String,
      budget: (json['budget'] as num).toDouble(),
      description: json['description'] as String,
      startday: DateTime.parse(json['startday'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProjectDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      people: (json['people'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : User.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ProjectDetailToJson(ProjectDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'material': instance.material,
      'budget': instance.budget,
      'description': instance.description,
      'startday': instance.startday.toIso8601String(),
      'deadline': instance.deadline.toIso8601String(),
      'status': instance.status,
      'people': instance.people,
      'projects': instance.projects,
    };
