// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutState {
  WorkoutSession get session => throw _privateConstructorUsedError;
  String get dayName => throw _privateConstructorUsedError;
  List<ProgramExercise> get exercises => throw _privateConstructorUsedError;
  int get currentExerciseIndex =>
      throw _privateConstructorUsedError; // Key: programExerciseId → lista de SetRecord gravadas nesta sessão
  Map<int, List<SetRecord>> get recordedSets =>
      throw _privateConstructorUsedError; // Key: programExerciseId → última carga usada (pre-fill)
  Map<int, double> get lastSessionLoad => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutStateCopyWith<WorkoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutStateCopyWith<$Res> {
  factory $WorkoutStateCopyWith(
    WorkoutState value,
    $Res Function(WorkoutState) then,
  ) = _$WorkoutStateCopyWithImpl<$Res, WorkoutState>;
  @useResult
  $Res call({
    WorkoutSession session,
    String dayName,
    List<ProgramExercise> exercises,
    int currentExerciseIndex,
    Map<int, List<SetRecord>> recordedSets,
    Map<int, double> lastSessionLoad,
  });

  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class _$WorkoutStateCopyWithImpl<$Res, $Val extends WorkoutState>
    implements $WorkoutStateCopyWith<$Res> {
  _$WorkoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? dayName = null,
    Object? exercises = null,
    Object? currentExerciseIndex = null,
    Object? recordedSets = null,
    Object? lastSessionLoad = null,
  }) {
    return _then(
      _value.copyWith(
            session: null == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as WorkoutSession,
            dayName: null == dayName
                ? _value.dayName
                : dayName // ignore: cast_nullable_to_non_nullable
                      as String,
            exercises: null == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<ProgramExercise>,
            currentExerciseIndex: null == currentExerciseIndex
                ? _value.currentExerciseIndex
                : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            recordedSets: null == recordedSets
                ? _value.recordedSets
                : recordedSets // ignore: cast_nullable_to_non_nullable
                      as Map<int, List<SetRecord>>,
            lastSessionLoad: null == lastSessionLoad
                ? _value.lastSessionLoad
                : lastSessionLoad // ignore: cast_nullable_to_non_nullable
                      as Map<int, double>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res> get session {
    return $WorkoutSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutStateImplCopyWith<$Res>
    implements $WorkoutStateCopyWith<$Res> {
  factory _$$WorkoutStateImplCopyWith(
    _$WorkoutStateImpl value,
    $Res Function(_$WorkoutStateImpl) then,
  ) = __$$WorkoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutSession session,
    String dayName,
    List<ProgramExercise> exercises,
    int currentExerciseIndex,
    Map<int, List<SetRecord>> recordedSets,
    Map<int, double> lastSessionLoad,
  });

  @override
  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$WorkoutStateImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutStateImpl>
    implements _$$WorkoutStateImplCopyWith<$Res> {
  __$$WorkoutStateImplCopyWithImpl(
    _$WorkoutStateImpl _value,
    $Res Function(_$WorkoutStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? dayName = null,
    Object? exercises = null,
    Object? currentExerciseIndex = null,
    Object? recordedSets = null,
    Object? lastSessionLoad = null,
  }) {
    return _then(
      _$WorkoutStateImpl(
        session: null == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as WorkoutSession,
        dayName: null == dayName
            ? _value.dayName
            : dayName // ignore: cast_nullable_to_non_nullable
                  as String,
        exercises: null == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<ProgramExercise>,
        currentExerciseIndex: null == currentExerciseIndex
            ? _value.currentExerciseIndex
            : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        recordedSets: null == recordedSets
            ? _value._recordedSets
            : recordedSets // ignore: cast_nullable_to_non_nullable
                  as Map<int, List<SetRecord>>,
        lastSessionLoad: null == lastSessionLoad
            ? _value._lastSessionLoad
            : lastSessionLoad // ignore: cast_nullable_to_non_nullable
                  as Map<int, double>,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutStateImpl extends _WorkoutState {
  const _$WorkoutStateImpl({
    required this.session,
    required this.dayName,
    required final List<ProgramExercise> exercises,
    this.currentExerciseIndex = 0,
    final Map<int, List<SetRecord>> recordedSets = const {},
    final Map<int, double> lastSessionLoad = const {},
  }) : _exercises = exercises,
       _recordedSets = recordedSets,
       _lastSessionLoad = lastSessionLoad,
       super._();

  @override
  final WorkoutSession session;
  @override
  final String dayName;
  final List<ProgramExercise> _exercises;
  @override
  List<ProgramExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  @JsonKey()
  final int currentExerciseIndex;
  // Key: programExerciseId → lista de SetRecord gravadas nesta sessão
  final Map<int, List<SetRecord>> _recordedSets;
  // Key: programExerciseId → lista de SetRecord gravadas nesta sessão
  @override
  @JsonKey()
  Map<int, List<SetRecord>> get recordedSets {
    if (_recordedSets is EqualUnmodifiableMapView) return _recordedSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_recordedSets);
  }

  // Key: programExerciseId → última carga usada (pre-fill)
  final Map<int, double> _lastSessionLoad;
  // Key: programExerciseId → última carga usada (pre-fill)
  @override
  @JsonKey()
  Map<int, double> get lastSessionLoad {
    if (_lastSessionLoad is EqualUnmodifiableMapView) return _lastSessionLoad;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastSessionLoad);
  }

  @override
  String toString() {
    return 'WorkoutState(session: $session, dayName: $dayName, exercises: $exercises, currentExerciseIndex: $currentExerciseIndex, recordedSets: $recordedSets, lastSessionLoad: $lastSessionLoad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutStateImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.dayName, dayName) || other.dayName == dayName) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ) &&
            (identical(other.currentExerciseIndex, currentExerciseIndex) ||
                other.currentExerciseIndex == currentExerciseIndex) &&
            const DeepCollectionEquality().equals(
              other._recordedSets,
              _recordedSets,
            ) &&
            const DeepCollectionEquality().equals(
              other._lastSessionLoad,
              _lastSessionLoad,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    session,
    dayName,
    const DeepCollectionEquality().hash(_exercises),
    currentExerciseIndex,
    const DeepCollectionEquality().hash(_recordedSets),
    const DeepCollectionEquality().hash(_lastSessionLoad),
  );

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutStateImplCopyWith<_$WorkoutStateImpl> get copyWith =>
      __$$WorkoutStateImplCopyWithImpl<_$WorkoutStateImpl>(this, _$identity);
}

abstract class _WorkoutState extends WorkoutState {
  const factory _WorkoutState({
    required final WorkoutSession session,
    required final String dayName,
    required final List<ProgramExercise> exercises,
    final int currentExerciseIndex,
    final Map<int, List<SetRecord>> recordedSets,
    final Map<int, double> lastSessionLoad,
  }) = _$WorkoutStateImpl;
  const _WorkoutState._() : super._();

  @override
  WorkoutSession get session;
  @override
  String get dayName;
  @override
  List<ProgramExercise> get exercises;
  @override
  int get currentExerciseIndex; // Key: programExerciseId → lista de SetRecord gravadas nesta sessão
  @override
  Map<int, List<SetRecord>> get recordedSets; // Key: programExerciseId → última carga usada (pre-fill)
  @override
  Map<int, double> get lastSessionLoad;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutStateImplCopyWith<_$WorkoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
