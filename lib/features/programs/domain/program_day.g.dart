// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramDayImpl _$$ProgramDayImplFromJson(Map<String, dynamic> json) =>
    _$ProgramDayImpl(
      id: (json['id'] as num).toInt(),
      programId: (json['programId'] as num).toInt(),
      name: json['name'] as String,
      dayOrder: (json['dayOrder'] as num).toInt(),
    );

Map<String, dynamic> _$$ProgramDayImplToJson(_$ProgramDayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'programId': instance.programId,
      'name': instance.name,
      'dayOrder': instance.dayOrder,
    };
