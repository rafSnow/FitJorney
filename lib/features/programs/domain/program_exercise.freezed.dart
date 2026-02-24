// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProgramExercise _$ProgramExerciseFromJson(Map<String, dynamic> json) {
  return _ProgramExercise.fromJson(json);
}

/// @nodoc
mixin _$ProgramExercise {
  int get id => throw _privateConstructorUsedError;
  int get programDayId => throw _privateConstructorUsedError;
  int get exerciseId => throw _privateConstructorUsedError;
  int get exerciseOrder => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  int get repMin => throw _privateConstructorUsedError;
  int get repMax => throw _privateConstructorUsedError;
  int? get rpeTarget => throw _privateConstructorUsedError;
  int get restSeconds => throw _privateConstructorUsedError;

  /// Nome do exercício (join do banco).
  String? get exerciseName => throw _privateConstructorUsedError;

  /// Serializes this ProgramExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramExerciseCopyWith<ProgramExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramExerciseCopyWith<$Res> {
  factory $ProgramExerciseCopyWith(
    ProgramExercise value,
    $Res Function(ProgramExercise) then,
  ) = _$ProgramExerciseCopyWithImpl<$Res, ProgramExercise>;
  @useResult
  $Res call({
    int id,
    int programDayId,
    int exerciseId,
    int exerciseOrder,
    int sets,
    int repMin,
    int repMax,
    int? rpeTarget,
    int restSeconds,
    String? exerciseName,
  });
}

/// @nodoc
class _$ProgramExerciseCopyWithImpl<$Res, $Val extends ProgramExercise>
    implements $ProgramExerciseCopyWith<$Res> {
  _$ProgramExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? programDayId = null,
    Object? exerciseId = null,
    Object? exerciseOrder = null,
    Object? sets = null,
    Object? repMin = null,
    Object? repMax = null,
    Object? rpeTarget = freezed,
    Object? restSeconds = null,
    Object? exerciseName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            programDayId: null == programDayId
                ? _value.programDayId
                : programDayId // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseOrder: null == exerciseOrder
                ? _value.exerciseOrder
                : exerciseOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as int,
            repMin: null == repMin
                ? _value.repMin
                : repMin // ignore: cast_nullable_to_non_nullable
                      as int,
            repMax: null == repMax
                ? _value.repMax
                : repMax // ignore: cast_nullable_to_non_nullable
                      as int,
            rpeTarget: freezed == rpeTarget
                ? _value.rpeTarget
                : rpeTarget // ignore: cast_nullable_to_non_nullable
                      as int?,
            restSeconds: null == restSeconds
                ? _value.restSeconds
                : restSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseName: freezed == exerciseName
                ? _value.exerciseName
                : exerciseName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramExerciseImplCopyWith<$Res>
    implements $ProgramExerciseCopyWith<$Res> {
  factory _$$ProgramExerciseImplCopyWith(
    _$ProgramExerciseImpl value,
    $Res Function(_$ProgramExerciseImpl) then,
  ) = __$$ProgramExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int programDayId,
    int exerciseId,
    int exerciseOrder,
    int sets,
    int repMin,
    int repMax,
    int? rpeTarget,
    int restSeconds,
    String? exerciseName,
  });
}

/// @nodoc
class __$$ProgramExerciseImplCopyWithImpl<$Res>
    extends _$ProgramExerciseCopyWithImpl<$Res, _$ProgramExerciseImpl>
    implements _$$ProgramExerciseImplCopyWith<$Res> {
  __$$ProgramExerciseImplCopyWithImpl(
    _$ProgramExerciseImpl _value,
    $Res Function(_$ProgramExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? programDayId = null,
    Object? exerciseId = null,
    Object? exerciseOrder = null,
    Object? sets = null,
    Object? repMin = null,
    Object? repMax = null,
    Object? rpeTarget = freezed,
    Object? restSeconds = null,
    Object? exerciseName = freezed,
  }) {
    return _then(
      _$ProgramExerciseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        programDayId: null == programDayId
            ? _value.programDayId
            : programDayId // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseOrder: null == exerciseOrder
            ? _value.exerciseOrder
            : exerciseOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        sets: null == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as int,
        repMin: null == repMin
            ? _value.repMin
            : repMin // ignore: cast_nullable_to_non_nullable
                  as int,
        repMax: null == repMax
            ? _value.repMax
            : repMax // ignore: cast_nullable_to_non_nullable
                  as int,
        rpeTarget: freezed == rpeTarget
            ? _value.rpeTarget
            : rpeTarget // ignore: cast_nullable_to_non_nullable
                  as int?,
        restSeconds: null == restSeconds
            ? _value.restSeconds
            : restSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseName: freezed == exerciseName
            ? _value.exerciseName
            : exerciseName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramExerciseImpl implements _ProgramExercise {
  const _$ProgramExerciseImpl({
    required this.id,
    required this.programDayId,
    required this.exerciseId,
    required this.exerciseOrder,
    required this.sets,
    required this.repMin,
    required this.repMax,
    this.rpeTarget,
    this.restSeconds = 90,
    this.exerciseName,
  });

  factory _$ProgramExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramExerciseImplFromJson(json);

  @override
  final int id;
  @override
  final int programDayId;
  @override
  final int exerciseId;
  @override
  final int exerciseOrder;
  @override
  final int sets;
  @override
  final int repMin;
  @override
  final int repMax;
  @override
  final int? rpeTarget;
  @override
  @JsonKey()
  final int restSeconds;

  /// Nome do exercício (join do banco).
  @override
  final String? exerciseName;

  @override
  String toString() {
    return 'ProgramExercise(id: $id, programDayId: $programDayId, exerciseId: $exerciseId, exerciseOrder: $exerciseOrder, sets: $sets, repMin: $repMin, repMax: $repMax, rpeTarget: $rpeTarget, restSeconds: $restSeconds, exerciseName: $exerciseName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.programDayId, programDayId) ||
                other.programDayId == programDayId) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseOrder, exerciseOrder) ||
                other.exerciseOrder == exerciseOrder) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.repMin, repMin) || other.repMin == repMin) &&
            (identical(other.repMax, repMax) || other.repMax == repMax) &&
            (identical(other.rpeTarget, rpeTarget) ||
                other.rpeTarget == rpeTarget) &&
            (identical(other.restSeconds, restSeconds) ||
                other.restSeconds == restSeconds) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    programDayId,
    exerciseId,
    exerciseOrder,
    sets,
    repMin,
    repMax,
    rpeTarget,
    restSeconds,
    exerciseName,
  );

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramExerciseImplCopyWith<_$ProgramExerciseImpl> get copyWith =>
      __$$ProgramExerciseImplCopyWithImpl<_$ProgramExerciseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramExerciseImplToJson(this);
  }
}

abstract class _ProgramExercise implements ProgramExercise {
  const factory _ProgramExercise({
    required final int id,
    required final int programDayId,
    required final int exerciseId,
    required final int exerciseOrder,
    required final int sets,
    required final int repMin,
    required final int repMax,
    final int? rpeTarget,
    final int restSeconds,
    final String? exerciseName,
  }) = _$ProgramExerciseImpl;

  factory _ProgramExercise.fromJson(Map<String, dynamic> json) =
      _$ProgramExerciseImpl.fromJson;

  @override
  int get id;
  @override
  int get programDayId;
  @override
  int get exerciseId;
  @override
  int get exerciseOrder;
  @override
  int get sets;
  @override
  int get repMin;
  @override
  int get repMax;
  @override
  int? get rpeTarget;
  @override
  int get restSeconds;

  /// Nome do exercício (join do banco).
  @override
  String? get exerciseName;

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramExerciseImplCopyWith<_$ProgramExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
