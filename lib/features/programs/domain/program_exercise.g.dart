// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramExerciseImpl _$$ProgramExerciseImplFromJson(
  Map<String, dynamic> json,
) => _$ProgramExerciseImpl(
  id: (json['id'] as num).toInt(),
  programDayId: (json['programDayId'] as num).toInt(),
  exerciseId: (json['exerciseId'] as num).toInt(),
  exerciseOrder: (json['exerciseOrder'] as num).toInt(),
  sets: (json['sets'] as num).toInt(),
  repMin: (json['repMin'] as num).toInt(),
  repMax: (json['repMax'] as num).toInt(),
  rpeTarget: (json['rpeTarget'] as num?)?.toInt(),
  restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 90,
  exerciseName: json['exerciseName'] as String?,
);

Map<String, dynamic> _$$ProgramExerciseImplToJson(
  _$ProgramExerciseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'programDayId': instance.programDayId,
  'exerciseId': instance.exerciseId,
  'exerciseOrder': instance.exerciseOrder,
  'sets': instance.sets,
  'repMin': instance.repMin,
  'repMax': instance.repMax,
  'rpeTarget': instance.rpeTarget,
  'restSeconds': instance.restSeconds,
  'exerciseName': instance.exerciseName,
};
