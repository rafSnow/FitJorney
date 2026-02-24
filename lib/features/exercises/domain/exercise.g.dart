// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      muscleGroup: $enumDecode(_$MuscleGroupEnumMap, json['muscleGroup']),
      muscleSize: $enumDecode(_$MuscleSizeEnumMap, json['muscleSize']),
      exerciseType: $enumDecode(_$ExerciseTypeEnumMap, json['exerciseType']),
      metricType: $enumDecode(_$MetricTypeEnumMap, json['metricType']),
      youtubeUrl: json['youtubeUrl'] as String?,
      customIncrement: (json['customIncrement'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'muscleGroup': _$MuscleGroupEnumMap[instance.muscleGroup]!,
      'muscleSize': _$MuscleSizeEnumMap[instance.muscleSize]!,
      'exerciseType': _$ExerciseTypeEnumMap[instance.exerciseType]!,
      'metricType': _$MetricTypeEnumMap[instance.metricType]!,
      'youtubeUrl': instance.youtubeUrl,
      'customIncrement': instance.customIncrement,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

const _$MuscleGroupEnumMap = {
  MuscleGroup.chest: 'chest',
  MuscleGroup.back: 'back',
  MuscleGroup.shoulders: 'shoulders',
  MuscleGroup.biceps: 'biceps',
  MuscleGroup.triceps: 'triceps',
  MuscleGroup.forearm: 'forearm',
  MuscleGroup.quadriceps: 'quadriceps',
  MuscleGroup.hamstrings: 'hamstrings',
  MuscleGroup.glutes: 'glutes',
  MuscleGroup.calves: 'calves',
  MuscleGroup.core: 'core',
  MuscleGroup.fullBody: 'fullBody',
};

const _$MuscleSizeEnumMap = {
  MuscleSize.large: 'large',
  MuscleSize.small: 'small',
};

const _$ExerciseTypeEnumMap = {
  ExerciseType.compound: 'compound',
  ExerciseType.isolation: 'isolation',
};

const _$MetricTypeEnumMap = {
  MetricType.loadKg: 'loadKg',
  MetricType.timeSeconds: 'timeSeconds',
};
