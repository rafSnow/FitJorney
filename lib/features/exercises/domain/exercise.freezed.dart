// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  MuscleGroup get muscleGroup => throw _privateConstructorUsedError;
  MuscleSize get muscleSize => throw _privateConstructorUsedError;
  ExerciseType get exerciseType => throw _privateConstructorUsedError;
  MetricType get metricType => throw _privateConstructorUsedError;
  String? get youtubeUrl => throw _privateConstructorUsedError;
  double? get customIncrement => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call({
    int id,
    String name,
    MuscleGroup muscleGroup,
    MuscleSize muscleSize,
    ExerciseType exerciseType,
    MetricType metricType,
    String? youtubeUrl,
    double? customIncrement,
    DateTime createdAt,
    bool isDeleted,
  });
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? muscleGroup = null,
    Object? muscleSize = null,
    Object? exerciseType = null,
    Object? metricType = null,
    Object? youtubeUrl = freezed,
    Object? customIncrement = freezed,
    Object? createdAt = null,
    Object? isDeleted = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            muscleGroup: null == muscleGroup
                ? _value.muscleGroup
                : muscleGroup // ignore: cast_nullable_to_non_nullable
                      as MuscleGroup,
            muscleSize: null == muscleSize
                ? _value.muscleSize
                : muscleSize // ignore: cast_nullable_to_non_nullable
                      as MuscleSize,
            exerciseType: null == exerciseType
                ? _value.exerciseType
                : exerciseType // ignore: cast_nullable_to_non_nullable
                      as ExerciseType,
            metricType: null == metricType
                ? _value.metricType
                : metricType // ignore: cast_nullable_to_non_nullable
                      as MetricType,
            youtubeUrl: freezed == youtubeUrl
                ? _value.youtubeUrl
                : youtubeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            customIncrement: freezed == customIncrement
                ? _value.customIncrement
                : customIncrement // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
    _$ExerciseImpl value,
    $Res Function(_$ExerciseImpl) then,
  ) = __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    MuscleGroup muscleGroup,
    MuscleSize muscleSize,
    ExerciseType exerciseType,
    MetricType metricType,
    String? youtubeUrl,
    double? customIncrement,
    DateTime createdAt,
    bool isDeleted,
  });
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
    _$ExerciseImpl _value,
    $Res Function(_$ExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? muscleGroup = null,
    Object? muscleSize = null,
    Object? exerciseType = null,
    Object? metricType = null,
    Object? youtubeUrl = freezed,
    Object? customIncrement = freezed,
    Object? createdAt = null,
    Object? isDeleted = null,
  }) {
    return _then(
      _$ExerciseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        muscleGroup: null == muscleGroup
            ? _value.muscleGroup
            : muscleGroup // ignore: cast_nullable_to_non_nullable
                  as MuscleGroup,
        muscleSize: null == muscleSize
            ? _value.muscleSize
            : muscleSize // ignore: cast_nullable_to_non_nullable
                  as MuscleSize,
        exerciseType: null == exerciseType
            ? _value.exerciseType
            : exerciseType // ignore: cast_nullable_to_non_nullable
                  as ExerciseType,
        metricType: null == metricType
            ? _value.metricType
            : metricType // ignore: cast_nullable_to_non_nullable
                  as MetricType,
        youtubeUrl: freezed == youtubeUrl
            ? _value.youtubeUrl
            : youtubeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        customIncrement: freezed == customIncrement
            ? _value.customIncrement
            : customIncrement // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.muscleSize,
    required this.exerciseType,
    required this.metricType,
    this.youtubeUrl,
    this.customIncrement,
    required this.createdAt,
    this.isDeleted = false,
  });

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final MuscleGroup muscleGroup;
  @override
  final MuscleSize muscleSize;
  @override
  final ExerciseType exerciseType;
  @override
  final MetricType metricType;
  @override
  final String? youtubeUrl;
  @override
  final double? customIncrement;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, muscleGroup: $muscleGroup, muscleSize: $muscleSize, exerciseType: $exerciseType, metricType: $metricType, youtubeUrl: $youtubeUrl, customIncrement: $customIncrement, createdAt: $createdAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.muscleGroup, muscleGroup) ||
                other.muscleGroup == muscleGroup) &&
            (identical(other.muscleSize, muscleSize) ||
                other.muscleSize == muscleSize) &&
            (identical(other.exerciseType, exerciseType) ||
                other.exerciseType == exerciseType) &&
            (identical(other.metricType, metricType) ||
                other.metricType == metricType) &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.customIncrement, customIncrement) ||
                other.customIncrement == customIncrement) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    muscleGroup,
    muscleSize,
    exerciseType,
    metricType,
    youtubeUrl,
    customIncrement,
    createdAt,
    isDeleted,
  );

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(this);
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise({
    required final int id,
    required final String name,
    required final MuscleGroup muscleGroup,
    required final MuscleSize muscleSize,
    required final ExerciseType exerciseType,
    required final MetricType metricType,
    final String? youtubeUrl,
    final double? customIncrement,
    required final DateTime createdAt,
    final bool isDeleted,
  }) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  MuscleGroup get muscleGroup;
  @override
  MuscleSize get muscleSize;
  @override
  ExerciseType get exerciseType;
  @override
  MetricType get metricType;
  @override
  String? get youtubeUrl;
  @override
  double? get customIncrement;
  @override
  DateTime get createdAt;
  @override
  bool get isDeleted;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
