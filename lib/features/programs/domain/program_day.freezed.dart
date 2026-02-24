// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProgramDay _$ProgramDayFromJson(Map<String, dynamic> json) {
  return _ProgramDay.fromJson(json);
}

/// @nodoc
mixin _$ProgramDay {
  int get id => throw _privateConstructorUsedError;
  int get programId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get dayOrder => throw _privateConstructorUsedError;

  /// Serializes this ProgramDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramDayCopyWith<ProgramDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramDayCopyWith<$Res> {
  factory $ProgramDayCopyWith(
    ProgramDay value,
    $Res Function(ProgramDay) then,
  ) = _$ProgramDayCopyWithImpl<$Res, ProgramDay>;
  @useResult
  $Res call({int id, int programId, String name, int dayOrder});
}

/// @nodoc
class _$ProgramDayCopyWithImpl<$Res, $Val extends ProgramDay>
    implements $ProgramDayCopyWith<$Res> {
  _$ProgramDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? programId = null,
    Object? name = null,
    Object? dayOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            programId: null == programId
                ? _value.programId
                : programId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            dayOrder: null == dayOrder
                ? _value.dayOrder
                : dayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramDayImplCopyWith<$Res>
    implements $ProgramDayCopyWith<$Res> {
  factory _$$ProgramDayImplCopyWith(
    _$ProgramDayImpl value,
    $Res Function(_$ProgramDayImpl) then,
  ) = __$$ProgramDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int programId, String name, int dayOrder});
}

/// @nodoc
class __$$ProgramDayImplCopyWithImpl<$Res>
    extends _$ProgramDayCopyWithImpl<$Res, _$ProgramDayImpl>
    implements _$$ProgramDayImplCopyWith<$Res> {
  __$$ProgramDayImplCopyWithImpl(
    _$ProgramDayImpl _value,
    $Res Function(_$ProgramDayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? programId = null,
    Object? name = null,
    Object? dayOrder = null,
  }) {
    return _then(
      _$ProgramDayImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        programId: null == programId
            ? _value.programId
            : programId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        dayOrder: null == dayOrder
            ? _value.dayOrder
            : dayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramDayImpl implements _ProgramDay {
  const _$ProgramDayImpl({
    required this.id,
    required this.programId,
    required this.name,
    required this.dayOrder,
  });

  factory _$ProgramDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramDayImplFromJson(json);

  @override
  final int id;
  @override
  final int programId;
  @override
  final String name;
  @override
  final int dayOrder;

  @override
  String toString() {
    return 'ProgramDay(id: $id, programId: $programId, name: $name, dayOrder: $dayOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramDayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.programId, programId) ||
                other.programId == programId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dayOrder, dayOrder) ||
                other.dayOrder == dayOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, programId, name, dayOrder);

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      __$$ProgramDayImplCopyWithImpl<_$ProgramDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramDayImplToJson(this);
  }
}

abstract class _ProgramDay implements ProgramDay {
  const factory _ProgramDay({
    required final int id,
    required final int programId,
    required final String name,
    required final int dayOrder,
  }) = _$ProgramDayImpl;

  factory _ProgramDay.fromJson(Map<String, dynamic> json) =
      _$ProgramDayImpl.fromJson;

  @override
  int get id;
  @override
  int get programId;
  @override
  String get name;
  @override
  int get dayOrder;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
