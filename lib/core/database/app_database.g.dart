// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleSizeMeta = const VerificationMeta(
    'muscleSize',
  );
  @override
  late final GeneratedColumn<String> muscleSize = GeneratedColumn<String>(
    'muscle_size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseTypeMeta = const VerificationMeta(
    'exerciseType',
  );
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
    'exercise_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricTypeMeta = const VerificationMeta(
    'metricType',
  );
  @override
  late final GeneratedColumn<String> metricType = GeneratedColumn<String>(
    'metric_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _youtubeUrlMeta = const VerificationMeta(
    'youtubeUrl',
  );
  @override
  late final GeneratedColumn<String> youtubeUrl = GeneratedColumn<String>(
    'youtube_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customIncrementMeta = const VerificationMeta(
    'customIncrement',
  );
  @override
  late final GeneratedColumn<double> customIncrement = GeneratedColumn<double>(
    'custom_increment',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('muscle_size')) {
      context.handle(
        _muscleSizeMeta,
        muscleSize.isAcceptableOrUnknown(data['muscle_size']!, _muscleSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_muscleSizeMeta);
    }
    if (data.containsKey('exercise_type')) {
      context.handle(
        _exerciseTypeMeta,
        exerciseType.isAcceptableOrUnknown(
          data['exercise_type']!,
          _exerciseTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseTypeMeta);
    }
    if (data.containsKey('metric_type')) {
      context.handle(
        _metricTypeMeta,
        metricType.isAcceptableOrUnknown(data['metric_type']!, _metricTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_metricTypeMeta);
    }
    if (data.containsKey('youtube_url')) {
      context.handle(
        _youtubeUrlMeta,
        youtubeUrl.isAcceptableOrUnknown(data['youtube_url']!, _youtubeUrlMeta),
      );
    }
    if (data.containsKey('custom_increment')) {
      context.handle(
        _customIncrementMeta,
        customIncrement.isAcceptableOrUnknown(
          data['custom_increment']!,
          _customIncrementMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      muscleSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_size'],
      )!,
      exerciseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_type'],
      )!,
      metricType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric_type'],
      )!,
      youtubeUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_url'],
      ),
      customIncrement: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}custom_increment'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String muscleGroup;
  final String muscleSize;
  final String exerciseType;
  final String metricType;
  final String? youtubeUrl;
  final double? customIncrement;
  final DateTime createdAt;
  final bool isDeleted;
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.muscleSize,
    required this.exerciseType,
    required this.metricType,
    this.youtubeUrl,
    this.customIncrement,
    required this.createdAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['muscle_size'] = Variable<String>(muscleSize);
    map['exercise_type'] = Variable<String>(exerciseType);
    map['metric_type'] = Variable<String>(metricType);
    if (!nullToAbsent || youtubeUrl != null) {
      map['youtube_url'] = Variable<String>(youtubeUrl);
    }
    if (!nullToAbsent || customIncrement != null) {
      map['custom_increment'] = Variable<double>(customIncrement);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      muscleGroup: Value(muscleGroup),
      muscleSize: Value(muscleSize),
      exerciseType: Value(exerciseType),
      metricType: Value(metricType),
      youtubeUrl: youtubeUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(youtubeUrl),
      customIncrement: customIncrement == null && nullToAbsent
          ? const Value.absent()
          : Value(customIncrement),
      createdAt: Value(createdAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      muscleSize: serializer.fromJson<String>(json['muscleSize']),
      exerciseType: serializer.fromJson<String>(json['exerciseType']),
      metricType: serializer.fromJson<String>(json['metricType']),
      youtubeUrl: serializer.fromJson<String?>(json['youtubeUrl']),
      customIncrement: serializer.fromJson<double?>(json['customIncrement']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'muscleSize': serializer.toJson<String>(muscleSize),
      'exerciseType': serializer.toJson<String>(exerciseType),
      'metricType': serializer.toJson<String>(metricType),
      'youtubeUrl': serializer.toJson<String?>(youtubeUrl),
      'customIncrement': serializer.toJson<double?>(customIncrement),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Exercise copyWith({
    int? id,
    String? name,
    String? muscleGroup,
    String? muscleSize,
    String? exerciseType,
    String? metricType,
    Value<String?> youtubeUrl = const Value.absent(),
    Value<double?> customIncrement = const Value.absent(),
    DateTime? createdAt,
    bool? isDeleted,
  }) => Exercise(
    id: id ?? this.id,
    name: name ?? this.name,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    muscleSize: muscleSize ?? this.muscleSize,
    exerciseType: exerciseType ?? this.exerciseType,
    metricType: metricType ?? this.metricType,
    youtubeUrl: youtubeUrl.present ? youtubeUrl.value : this.youtubeUrl,
    customIncrement: customIncrement.present
        ? customIncrement.value
        : this.customIncrement,
    createdAt: createdAt ?? this.createdAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      muscleSize: data.muscleSize.present
          ? data.muscleSize.value
          : this.muscleSize,
      exerciseType: data.exerciseType.present
          ? data.exerciseType.value
          : this.exerciseType,
      metricType: data.metricType.present
          ? data.metricType.value
          : this.metricType,
      youtubeUrl: data.youtubeUrl.present
          ? data.youtubeUrl.value
          : this.youtubeUrl,
      customIncrement: data.customIncrement.present
          ? data.customIncrement.value
          : this.customIncrement,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('muscleSize: $muscleSize, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('metricType: $metricType, ')
          ..write('youtubeUrl: $youtubeUrl, ')
          ..write('customIncrement: $customIncrement, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.muscleGroup == this.muscleGroup &&
          other.muscleSize == this.muscleSize &&
          other.exerciseType == this.exerciseType &&
          other.metricType == this.metricType &&
          other.youtubeUrl == this.youtubeUrl &&
          other.customIncrement == this.customIncrement &&
          other.createdAt == this.createdAt &&
          other.isDeleted == this.isDeleted);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> muscleGroup;
  final Value<String> muscleSize;
  final Value<String> exerciseType;
  final Value<String> metricType;
  final Value<String?> youtubeUrl;
  final Value<double?> customIncrement;
  final Value<DateTime> createdAt;
  final Value<bool> isDeleted;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.muscleSize = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.metricType = const Value.absent(),
    this.youtubeUrl = const Value.absent(),
    this.customIncrement = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String muscleGroup,
    required String muscleSize,
    required String exerciseType,
    required String metricType,
    this.youtubeUrl = const Value.absent(),
    this.customIncrement = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : name = Value(name),
       muscleGroup = Value(muscleGroup),
       muscleSize = Value(muscleSize),
       exerciseType = Value(exerciseType),
       metricType = Value(metricType);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? muscleGroup,
    Expression<String>? muscleSize,
    Expression<String>? exerciseType,
    Expression<String>? metricType,
    Expression<String>? youtubeUrl,
    Expression<double>? customIncrement,
    Expression<DateTime>? createdAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (muscleSize != null) 'muscle_size': muscleSize,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (metricType != null) 'metric_type': metricType,
      if (youtubeUrl != null) 'youtube_url': youtubeUrl,
      if (customIncrement != null) 'custom_increment': customIncrement,
      if (createdAt != null) 'created_at': createdAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? muscleGroup,
    Value<String>? muscleSize,
    Value<String>? exerciseType,
    Value<String>? metricType,
    Value<String?>? youtubeUrl,
    Value<double?>? customIncrement,
    Value<DateTime>? createdAt,
    Value<bool>? isDeleted,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      muscleSize: muscleSize ?? this.muscleSize,
      exerciseType: exerciseType ?? this.exerciseType,
      metricType: metricType ?? this.metricType,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      customIncrement: customIncrement ?? this.customIncrement,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (muscleSize.present) {
      map['muscle_size'] = Variable<String>(muscleSize.value);
    }
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (metricType.present) {
      map['metric_type'] = Variable<String>(metricType.value);
    }
    if (youtubeUrl.present) {
      map['youtube_url'] = Variable<String>(youtubeUrl.value);
    }
    if (customIncrement.present) {
      map['custom_increment'] = Variable<double>(customIncrement.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('muscleSize: $muscleSize, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('metricType: $metricType, ')
          ..write('youtubeUrl: $youtubeUrl, ')
          ..write('customIncrement: $customIncrement, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $ProgramsTable extends Programs with TableInfo<$ProgramsTable, Program> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'programs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Program> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Program map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Program(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProgramsTable createAlias(String alias) {
    return $ProgramsTable(attachedDatabase, alias);
  }
}

class Program extends DataClass implements Insertable<Program> {
  final int id;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  const Program({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProgramsCompanion toCompanion(bool nullToAbsent) {
    return ProgramsCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Program.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Program(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Program copyWith({
    int? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
  }) => Program(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Program copyWithCompanion(ProgramsCompanion data) {
    return Program(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Program(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Program &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class ProgramsCompanion extends UpdateCompanion<Program> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const ProgramsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProgramsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Program> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProgramsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return ProgramsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProgramDaysTable extends ProgramDays
    with TableInfo<$ProgramDaysTable, ProgramDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<int> programId = GeneratedColumn<int>(
    'program_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES programs (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOrderMeta = const VerificationMeta(
    'dayOrder',
  );
  @override
  late final GeneratedColumn<int> dayOrder = GeneratedColumn<int>(
    'day_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, programId, name, dayOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'program_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgramDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    } else if (isInserting) {
      context.missing(_programIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('day_order')) {
      context.handle(
        _dayOrderMeta,
        dayOrder.isAcceptableOrUnknown(data['day_order']!, _dayOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgramDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgramDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_order'],
      )!,
    );
  }

  @override
  $ProgramDaysTable createAlias(String alias) {
    return $ProgramDaysTable(attachedDatabase, alias);
  }
}

class ProgramDay extends DataClass implements Insertable<ProgramDay> {
  final int id;
  final int programId;
  final String name;
  final int dayOrder;
  const ProgramDay({
    required this.id,
    required this.programId,
    required this.name,
    required this.dayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['program_id'] = Variable<int>(programId);
    map['name'] = Variable<String>(name);
    map['day_order'] = Variable<int>(dayOrder);
    return map;
  }

  ProgramDaysCompanion toCompanion(bool nullToAbsent) {
    return ProgramDaysCompanion(
      id: Value(id),
      programId: Value(programId),
      name: Value(name),
      dayOrder: Value(dayOrder),
    );
  }

  factory ProgramDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgramDay(
      id: serializer.fromJson<int>(json['id']),
      programId: serializer.fromJson<int>(json['programId']),
      name: serializer.fromJson<String>(json['name']),
      dayOrder: serializer.fromJson<int>(json['dayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'programId': serializer.toJson<int>(programId),
      'name': serializer.toJson<String>(name),
      'dayOrder': serializer.toJson<int>(dayOrder),
    };
  }

  ProgramDay copyWith({int? id, int? programId, String? name, int? dayOrder}) =>
      ProgramDay(
        id: id ?? this.id,
        programId: programId ?? this.programId,
        name: name ?? this.name,
        dayOrder: dayOrder ?? this.dayOrder,
      );
  ProgramDay copyWithCompanion(ProgramDaysCompanion data) {
    return ProgramDay(
      id: data.id.present ? data.id.value : this.id,
      programId: data.programId.present ? data.programId.value : this.programId,
      name: data.name.present ? data.name.value : this.name,
      dayOrder: data.dayOrder.present ? data.dayOrder.value : this.dayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgramDay(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('name: $name, ')
          ..write('dayOrder: $dayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, programId, name, dayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgramDay &&
          other.id == this.id &&
          other.programId == this.programId &&
          other.name == this.name &&
          other.dayOrder == this.dayOrder);
}

class ProgramDaysCompanion extends UpdateCompanion<ProgramDay> {
  final Value<int> id;
  final Value<int> programId;
  final Value<String> name;
  final Value<int> dayOrder;
  const ProgramDaysCompanion({
    this.id = const Value.absent(),
    this.programId = const Value.absent(),
    this.name = const Value.absent(),
    this.dayOrder = const Value.absent(),
  });
  ProgramDaysCompanion.insert({
    this.id = const Value.absent(),
    required int programId,
    required String name,
    required int dayOrder,
  }) : programId = Value(programId),
       name = Value(name),
       dayOrder = Value(dayOrder);
  static Insertable<ProgramDay> custom({
    Expression<int>? id,
    Expression<int>? programId,
    Expression<String>? name,
    Expression<int>? dayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programId != null) 'program_id': programId,
      if (name != null) 'name': name,
      if (dayOrder != null) 'day_order': dayOrder,
    });
  }

  ProgramDaysCompanion copyWith({
    Value<int>? id,
    Value<int>? programId,
    Value<String>? name,
    Value<int>? dayOrder,
  }) {
    return ProgramDaysCompanion(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      name: name ?? this.name,
      dayOrder: dayOrder ?? this.dayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<int>(programId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dayOrder.present) {
      map['day_order'] = Variable<int>(dayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramDaysCompanion(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('name: $name, ')
          ..write('dayOrder: $dayOrder')
          ..write(')'))
        .toString();
  }
}

class $ProgramExercisesTable extends ProgramExercises
    with TableInfo<$ProgramExercisesTable, ProgramExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _programDayIdMeta = const VerificationMeta(
    'programDayId',
  );
  @override
  late final GeneratedColumn<int> programDayId = GeneratedColumn<int>(
    'program_day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES program_days (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _exerciseOrderMeta = const VerificationMeta(
    'exerciseOrder',
  );
  @override
  late final GeneratedColumn<int> exerciseOrder = GeneratedColumn<int>(
    'exercise_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repMinMeta = const VerificationMeta('repMin');
  @override
  late final GeneratedColumn<int> repMin = GeneratedColumn<int>(
    'rep_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repMaxMeta = const VerificationMeta('repMax');
  @override
  late final GeneratedColumn<int> repMax = GeneratedColumn<int>(
    'rep_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rpeTargetMeta = const VerificationMeta(
    'rpeTarget',
  );
  @override
  late final GeneratedColumn<int> rpeTarget = GeneratedColumn<int>(
    'rpe_target',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    programDayId,
    exerciseId,
    exerciseOrder,
    sets,
    repMin,
    repMax,
    rpeTarget,
    restSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'program_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgramExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('program_day_id')) {
      context.handle(
        _programDayIdMeta,
        programDayId.isAcceptableOrUnknown(
          data['program_day_id']!,
          _programDayIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_programDayIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('exercise_order')) {
      context.handle(
        _exerciseOrderMeta,
        exerciseOrder.isAcceptableOrUnknown(
          data['exercise_order']!,
          _exerciseOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseOrderMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('rep_min')) {
      context.handle(
        _repMinMeta,
        repMin.isAcceptableOrUnknown(data['rep_min']!, _repMinMeta),
      );
    } else if (isInserting) {
      context.missing(_repMinMeta);
    }
    if (data.containsKey('rep_max')) {
      context.handle(
        _repMaxMeta,
        repMax.isAcceptableOrUnknown(data['rep_max']!, _repMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_repMaxMeta);
    }
    if (data.containsKey('rpe_target')) {
      context.handle(
        _rpeTargetMeta,
        rpeTarget.isAcceptableOrUnknown(data['rpe_target']!, _rpeTargetMeta),
      );
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgramExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgramExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      programDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_day_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      exerciseOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_order'],
      )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      )!,
      repMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rep_min'],
      )!,
      repMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rep_max'],
      )!,
      rpeTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rpe_target'],
      ),
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      )!,
    );
  }

  @override
  $ProgramExercisesTable createAlias(String alias) {
    return $ProgramExercisesTable(attachedDatabase, alias);
  }
}

class ProgramExercise extends DataClass implements Insertable<ProgramExercise> {
  final int id;
  final int programDayId;
  final int exerciseId;
  final int exerciseOrder;
  final int sets;
  final int repMin;
  final int repMax;
  final int? rpeTarget;
  final int restSeconds;
  const ProgramExercise({
    required this.id,
    required this.programDayId,
    required this.exerciseId,
    required this.exerciseOrder,
    required this.sets,
    required this.repMin,
    required this.repMax,
    this.rpeTarget,
    required this.restSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['program_day_id'] = Variable<int>(programDayId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['exercise_order'] = Variable<int>(exerciseOrder);
    map['sets'] = Variable<int>(sets);
    map['rep_min'] = Variable<int>(repMin);
    map['rep_max'] = Variable<int>(repMax);
    if (!nullToAbsent || rpeTarget != null) {
      map['rpe_target'] = Variable<int>(rpeTarget);
    }
    map['rest_seconds'] = Variable<int>(restSeconds);
    return map;
  }

  ProgramExercisesCompanion toCompanion(bool nullToAbsent) {
    return ProgramExercisesCompanion(
      id: Value(id),
      programDayId: Value(programDayId),
      exerciseId: Value(exerciseId),
      exerciseOrder: Value(exerciseOrder),
      sets: Value(sets),
      repMin: Value(repMin),
      repMax: Value(repMax),
      rpeTarget: rpeTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(rpeTarget),
      restSeconds: Value(restSeconds),
    );
  }

  factory ProgramExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgramExercise(
      id: serializer.fromJson<int>(json['id']),
      programDayId: serializer.fromJson<int>(json['programDayId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      exerciseOrder: serializer.fromJson<int>(json['exerciseOrder']),
      sets: serializer.fromJson<int>(json['sets']),
      repMin: serializer.fromJson<int>(json['repMin']),
      repMax: serializer.fromJson<int>(json['repMax']),
      rpeTarget: serializer.fromJson<int?>(json['rpeTarget']),
      restSeconds: serializer.fromJson<int>(json['restSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'programDayId': serializer.toJson<int>(programDayId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'exerciseOrder': serializer.toJson<int>(exerciseOrder),
      'sets': serializer.toJson<int>(sets),
      'repMin': serializer.toJson<int>(repMin),
      'repMax': serializer.toJson<int>(repMax),
      'rpeTarget': serializer.toJson<int?>(rpeTarget),
      'restSeconds': serializer.toJson<int>(restSeconds),
    };
  }

  ProgramExercise copyWith({
    int? id,
    int? programDayId,
    int? exerciseId,
    int? exerciseOrder,
    int? sets,
    int? repMin,
    int? repMax,
    Value<int?> rpeTarget = const Value.absent(),
    int? restSeconds,
  }) => ProgramExercise(
    id: id ?? this.id,
    programDayId: programDayId ?? this.programDayId,
    exerciseId: exerciseId ?? this.exerciseId,
    exerciseOrder: exerciseOrder ?? this.exerciseOrder,
    sets: sets ?? this.sets,
    repMin: repMin ?? this.repMin,
    repMax: repMax ?? this.repMax,
    rpeTarget: rpeTarget.present ? rpeTarget.value : this.rpeTarget,
    restSeconds: restSeconds ?? this.restSeconds,
  );
  ProgramExercise copyWithCompanion(ProgramExercisesCompanion data) {
    return ProgramExercise(
      id: data.id.present ? data.id.value : this.id,
      programDayId: data.programDayId.present
          ? data.programDayId.value
          : this.programDayId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
      sets: data.sets.present ? data.sets.value : this.sets,
      repMin: data.repMin.present ? data.repMin.value : this.repMin,
      repMax: data.repMax.present ? data.repMax.value : this.repMax,
      rpeTarget: data.rpeTarget.present ? data.rpeTarget.value : this.rpeTarget,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgramExercise(')
          ..write('id: $id, ')
          ..write('programDayId: $programDayId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('sets: $sets, ')
          ..write('repMin: $repMin, ')
          ..write('repMax: $repMax, ')
          ..write('rpeTarget: $rpeTarget, ')
          ..write('restSeconds: $restSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    programDayId,
    exerciseId,
    exerciseOrder,
    sets,
    repMin,
    repMax,
    rpeTarget,
    restSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgramExercise &&
          other.id == this.id &&
          other.programDayId == this.programDayId &&
          other.exerciseId == this.exerciseId &&
          other.exerciseOrder == this.exerciseOrder &&
          other.sets == this.sets &&
          other.repMin == this.repMin &&
          other.repMax == this.repMax &&
          other.rpeTarget == this.rpeTarget &&
          other.restSeconds == this.restSeconds);
}

class ProgramExercisesCompanion extends UpdateCompanion<ProgramExercise> {
  final Value<int> id;
  final Value<int> programDayId;
  final Value<int> exerciseId;
  final Value<int> exerciseOrder;
  final Value<int> sets;
  final Value<int> repMin;
  final Value<int> repMax;
  final Value<int?> rpeTarget;
  final Value<int> restSeconds;
  const ProgramExercisesCompanion({
    this.id = const Value.absent(),
    this.programDayId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
    this.sets = const Value.absent(),
    this.repMin = const Value.absent(),
    this.repMax = const Value.absent(),
    this.rpeTarget = const Value.absent(),
    this.restSeconds = const Value.absent(),
  });
  ProgramExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int programDayId,
    required int exerciseId,
    required int exerciseOrder,
    required int sets,
    required int repMin,
    required int repMax,
    this.rpeTarget = const Value.absent(),
    this.restSeconds = const Value.absent(),
  }) : programDayId = Value(programDayId),
       exerciseId = Value(exerciseId),
       exerciseOrder = Value(exerciseOrder),
       sets = Value(sets),
       repMin = Value(repMin),
       repMax = Value(repMax);
  static Insertable<ProgramExercise> custom({
    Expression<int>? id,
    Expression<int>? programDayId,
    Expression<int>? exerciseId,
    Expression<int>? exerciseOrder,
    Expression<int>? sets,
    Expression<int>? repMin,
    Expression<int>? repMax,
    Expression<int>? rpeTarget,
    Expression<int>? restSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programDayId != null) 'program_day_id': programDayId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (exerciseOrder != null) 'exercise_order': exerciseOrder,
      if (sets != null) 'sets': sets,
      if (repMin != null) 'rep_min': repMin,
      if (repMax != null) 'rep_max': repMax,
      if (rpeTarget != null) 'rpe_target': rpeTarget,
      if (restSeconds != null) 'rest_seconds': restSeconds,
    });
  }

  ProgramExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? programDayId,
    Value<int>? exerciseId,
    Value<int>? exerciseOrder,
    Value<int>? sets,
    Value<int>? repMin,
    Value<int>? repMax,
    Value<int?>? rpeTarget,
    Value<int>? restSeconds,
  }) {
    return ProgramExercisesCompanion(
      id: id ?? this.id,
      programDayId: programDayId ?? this.programDayId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      sets: sets ?? this.sets,
      repMin: repMin ?? this.repMin,
      repMax: repMax ?? this.repMax,
      rpeTarget: rpeTarget ?? this.rpeTarget,
      restSeconds: restSeconds ?? this.restSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (programDayId.present) {
      map['program_day_id'] = Variable<int>(programDayId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (exerciseOrder.present) {
      map['exercise_order'] = Variable<int>(exerciseOrder.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (repMin.present) {
      map['rep_min'] = Variable<int>(repMin.value);
    }
    if (repMax.present) {
      map['rep_max'] = Variable<int>(repMax.value);
    }
    if (rpeTarget.present) {
      map['rpe_target'] = Variable<int>(rpeTarget.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramExercisesCompanion(')
          ..write('id: $id, ')
          ..write('programDayId: $programDayId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('sets: $sets, ')
          ..write('repMin: $repMin, ')
          ..write('repMax: $repMax, ')
          ..write('rpeTarget: $rpeTarget, ')
          ..write('restSeconds: $restSeconds')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _programDayIdMeta = const VerificationMeta(
    'programDayId',
  );
  @override
  late final GeneratedColumn<int> programDayId = GeneratedColumn<int>(
    'program_day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES program_days (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('in_progress'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    programDayId,
    startedAt,
    finishedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('program_day_id')) {
      context.handle(
        _programDayIdMeta,
        programDayId.isAcceptableOrUnknown(
          data['program_day_id']!,
          _programDayIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_programDayIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      programDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_day_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final int id;
  final int programDayId;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final String status;
  const WorkoutSession({
    required this.id,
    required this.programDayId,
    required this.startedAt,
    this.finishedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['program_day_id'] = Variable<int>(programDayId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      programDayId: Value(programDayId),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      status: Value(status),
    );
  }

  factory WorkoutSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<int>(json['id']),
      programDayId: serializer.fromJson<int>(json['programDayId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'programDayId': serializer.toJson<int>(programDayId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  WorkoutSession copyWith({
    int? id,
    int? programDayId,
    DateTime? startedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
    String? status,
  }) => WorkoutSession(
    id: id ?? this.id,
    programDayId: programDayId ?? this.programDayId,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    status: status ?? this.status,
  );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      programDayId: data.programDayId.present
          ? data.programDayId.value
          : this.programDayId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('programDayId: $programDayId, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, programDayId, startedAt, finishedAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.programDayId == this.programDayId &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.status == this.status);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<int> id;
  final Value<int> programDayId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<String> status;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.programDayId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int programDayId,
    required DateTime startedAt,
    this.finishedAt = const Value.absent(),
    this.status = const Value.absent(),
  }) : programDayId = Value(programDayId),
       startedAt = Value(startedAt);
  static Insertable<WorkoutSession> custom({
    Expression<int>? id,
    Expression<int>? programDayId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programDayId != null) 'program_day_id': programDayId,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (status != null) 'status': status,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? programDayId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<String>? status,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      programDayId: programDayId ?? this.programDayId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (programDayId.present) {
      map['program_day_id'] = Variable<int>(programDayId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('programDayId: $programDayId, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $SetRecordsTable extends SetRecords
    with TableInfo<$SetRecordsTable, SetRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_sessions (id)',
    ),
  );
  static const VerificationMeta _programExerciseIdMeta = const VerificationMeta(
    'programExerciseId',
  );
  @override
  late final GeneratedColumn<int> programExerciseId = GeneratedColumn<int>(
    'program_exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES program_exercises (id)',
    ),
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loadKgMeta = const VerificationMeta('loadKg');
  @override
  late final GeneratedColumn<double> loadKg = GeneratedColumn<double>(
    'load_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeSecondsMeta = const VerificationMeta(
    'timeSeconds',
  );
  @override
  late final GeneratedColumn<int> timeSeconds = GeneratedColumn<int>(
    'time_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsCompletedMeta = const VerificationMeta(
    'repsCompleted',
  );
  @override
  late final GeneratedColumn<int> repsCompleted = GeneratedColumn<int>(
    'reps_completed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rpeAchievedMeta = const VerificationMeta(
    'rpeAchieved',
  );
  @override
  late final GeneratedColumn<int> rpeAchieved = GeneratedColumn<int>(
    'rpe_achieved',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isExtraMeta = const VerificationMeta(
    'isExtra',
  );
  @override
  late final GeneratedColumn<bool> isExtra = GeneratedColumn<bool>(
    'is_extra',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_extra" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _wasSkippedMeta = const VerificationMeta(
    'wasSkipped',
  );
  @override
  late final GeneratedColumn<bool> wasSkipped = GeneratedColumn<bool>(
    'was_skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    programExerciseId,
    setNumber,
    loadKg,
    timeSeconds,
    repsCompleted,
    rpeAchieved,
    recordedAt,
    isExtra,
    wasSkipped,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'set_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SetRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('program_exercise_id')) {
      context.handle(
        _programExerciseIdMeta,
        programExerciseId.isAcceptableOrUnknown(
          data['program_exercise_id']!,
          _programExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_programExerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('load_kg')) {
      context.handle(
        _loadKgMeta,
        loadKg.isAcceptableOrUnknown(data['load_kg']!, _loadKgMeta),
      );
    }
    if (data.containsKey('time_seconds')) {
      context.handle(
        _timeSecondsMeta,
        timeSeconds.isAcceptableOrUnknown(
          data['time_seconds']!,
          _timeSecondsMeta,
        ),
      );
    }
    if (data.containsKey('reps_completed')) {
      context.handle(
        _repsCompletedMeta,
        repsCompleted.isAcceptableOrUnknown(
          data['reps_completed']!,
          _repsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('rpe_achieved')) {
      context.handle(
        _rpeAchievedMeta,
        rpeAchieved.isAcceptableOrUnknown(
          data['rpe_achieved']!,
          _rpeAchievedMeta,
        ),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    }
    if (data.containsKey('is_extra')) {
      context.handle(
        _isExtraMeta,
        isExtra.isAcceptableOrUnknown(data['is_extra']!, _isExtraMeta),
      );
    }
    if (data.containsKey('was_skipped')) {
      context.handle(
        _wasSkippedMeta,
        wasSkipped.isAcceptableOrUnknown(data['was_skipped']!, _wasSkippedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      programExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_exercise_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      loadKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}load_kg'],
      ),
      timeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_seconds'],
      ),
      repsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps_completed'],
      ),
      rpeAchieved: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rpe_achieved'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      isExtra: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_extra'],
      )!,
      wasSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_skipped'],
      )!,
    );
  }

  @override
  $SetRecordsTable createAlias(String alias) {
    return $SetRecordsTable(attachedDatabase, alias);
  }
}

class SetRecord extends DataClass implements Insertable<SetRecord> {
  final int id;
  final int sessionId;
  final int programExerciseId;
  final int setNumber;
  final double? loadKg;
  final int? timeSeconds;
  final int? repsCompleted;
  final int? rpeAchieved;
  final DateTime recordedAt;
  final bool isExtra;
  final bool wasSkipped;
  const SetRecord({
    required this.id,
    required this.sessionId,
    required this.programExerciseId,
    required this.setNumber,
    this.loadKg,
    this.timeSeconds,
    this.repsCompleted,
    this.rpeAchieved,
    required this.recordedAt,
    required this.isExtra,
    required this.wasSkipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['program_exercise_id'] = Variable<int>(programExerciseId);
    map['set_number'] = Variable<int>(setNumber);
    if (!nullToAbsent || loadKg != null) {
      map['load_kg'] = Variable<double>(loadKg);
    }
    if (!nullToAbsent || timeSeconds != null) {
      map['time_seconds'] = Variable<int>(timeSeconds);
    }
    if (!nullToAbsent || repsCompleted != null) {
      map['reps_completed'] = Variable<int>(repsCompleted);
    }
    if (!nullToAbsent || rpeAchieved != null) {
      map['rpe_achieved'] = Variable<int>(rpeAchieved);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['is_extra'] = Variable<bool>(isExtra);
    map['was_skipped'] = Variable<bool>(wasSkipped);
    return map;
  }

  SetRecordsCompanion toCompanion(bool nullToAbsent) {
    return SetRecordsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      programExerciseId: Value(programExerciseId),
      setNumber: Value(setNumber),
      loadKg: loadKg == null && nullToAbsent
          ? const Value.absent()
          : Value(loadKg),
      timeSeconds: timeSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(timeSeconds),
      repsCompleted: repsCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(repsCompleted),
      rpeAchieved: rpeAchieved == null && nullToAbsent
          ? const Value.absent()
          : Value(rpeAchieved),
      recordedAt: Value(recordedAt),
      isExtra: Value(isExtra),
      wasSkipped: Value(wasSkipped),
    );
  }

  factory SetRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetRecord(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      programExerciseId: serializer.fromJson<int>(json['programExerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      loadKg: serializer.fromJson<double?>(json['loadKg']),
      timeSeconds: serializer.fromJson<int?>(json['timeSeconds']),
      repsCompleted: serializer.fromJson<int?>(json['repsCompleted']),
      rpeAchieved: serializer.fromJson<int?>(json['rpeAchieved']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      isExtra: serializer.fromJson<bool>(json['isExtra']),
      wasSkipped: serializer.fromJson<bool>(json['wasSkipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'programExerciseId': serializer.toJson<int>(programExerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'loadKg': serializer.toJson<double?>(loadKg),
      'timeSeconds': serializer.toJson<int?>(timeSeconds),
      'repsCompleted': serializer.toJson<int?>(repsCompleted),
      'rpeAchieved': serializer.toJson<int?>(rpeAchieved),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'isExtra': serializer.toJson<bool>(isExtra),
      'wasSkipped': serializer.toJson<bool>(wasSkipped),
    };
  }

  SetRecord copyWith({
    int? id,
    int? sessionId,
    int? programExerciseId,
    int? setNumber,
    Value<double?> loadKg = const Value.absent(),
    Value<int?> timeSeconds = const Value.absent(),
    Value<int?> repsCompleted = const Value.absent(),
    Value<int?> rpeAchieved = const Value.absent(),
    DateTime? recordedAt,
    bool? isExtra,
    bool? wasSkipped,
  }) => SetRecord(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    programExerciseId: programExerciseId ?? this.programExerciseId,
    setNumber: setNumber ?? this.setNumber,
    loadKg: loadKg.present ? loadKg.value : this.loadKg,
    timeSeconds: timeSeconds.present ? timeSeconds.value : this.timeSeconds,
    repsCompleted: repsCompleted.present
        ? repsCompleted.value
        : this.repsCompleted,
    rpeAchieved: rpeAchieved.present ? rpeAchieved.value : this.rpeAchieved,
    recordedAt: recordedAt ?? this.recordedAt,
    isExtra: isExtra ?? this.isExtra,
    wasSkipped: wasSkipped ?? this.wasSkipped,
  );
  SetRecord copyWithCompanion(SetRecordsCompanion data) {
    return SetRecord(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      programExerciseId: data.programExerciseId.present
          ? data.programExerciseId.value
          : this.programExerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      loadKg: data.loadKg.present ? data.loadKg.value : this.loadKg,
      timeSeconds: data.timeSeconds.present
          ? data.timeSeconds.value
          : this.timeSeconds,
      repsCompleted: data.repsCompleted.present
          ? data.repsCompleted.value
          : this.repsCompleted,
      rpeAchieved: data.rpeAchieved.present
          ? data.rpeAchieved.value
          : this.rpeAchieved,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      isExtra: data.isExtra.present ? data.isExtra.value : this.isExtra,
      wasSkipped: data.wasSkipped.present
          ? data.wasSkipped.value
          : this.wasSkipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetRecord(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('programExerciseId: $programExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('loadKg: $loadKg, ')
          ..write('timeSeconds: $timeSeconds, ')
          ..write('repsCompleted: $repsCompleted, ')
          ..write('rpeAchieved: $rpeAchieved, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('isExtra: $isExtra, ')
          ..write('wasSkipped: $wasSkipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    programExerciseId,
    setNumber,
    loadKg,
    timeSeconds,
    repsCompleted,
    rpeAchieved,
    recordedAt,
    isExtra,
    wasSkipped,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetRecord &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.programExerciseId == this.programExerciseId &&
          other.setNumber == this.setNumber &&
          other.loadKg == this.loadKg &&
          other.timeSeconds == this.timeSeconds &&
          other.repsCompleted == this.repsCompleted &&
          other.rpeAchieved == this.rpeAchieved &&
          other.recordedAt == this.recordedAt &&
          other.isExtra == this.isExtra &&
          other.wasSkipped == this.wasSkipped);
}

class SetRecordsCompanion extends UpdateCompanion<SetRecord> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> programExerciseId;
  final Value<int> setNumber;
  final Value<double?> loadKg;
  final Value<int?> timeSeconds;
  final Value<int?> repsCompleted;
  final Value<int?> rpeAchieved;
  final Value<DateTime> recordedAt;
  final Value<bool> isExtra;
  final Value<bool> wasSkipped;
  const SetRecordsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.programExerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.loadKg = const Value.absent(),
    this.timeSeconds = const Value.absent(),
    this.repsCompleted = const Value.absent(),
    this.rpeAchieved = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.isExtra = const Value.absent(),
    this.wasSkipped = const Value.absent(),
  });
  SetRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int programExerciseId,
    required int setNumber,
    this.loadKg = const Value.absent(),
    this.timeSeconds = const Value.absent(),
    this.repsCompleted = const Value.absent(),
    this.rpeAchieved = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.isExtra = const Value.absent(),
    this.wasSkipped = const Value.absent(),
  }) : sessionId = Value(sessionId),
       programExerciseId = Value(programExerciseId),
       setNumber = Value(setNumber);
  static Insertable<SetRecord> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? programExerciseId,
    Expression<int>? setNumber,
    Expression<double>? loadKg,
    Expression<int>? timeSeconds,
    Expression<int>? repsCompleted,
    Expression<int>? rpeAchieved,
    Expression<DateTime>? recordedAt,
    Expression<bool>? isExtra,
    Expression<bool>? wasSkipped,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (programExerciseId != null) 'program_exercise_id': programExerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (loadKg != null) 'load_kg': loadKg,
      if (timeSeconds != null) 'time_seconds': timeSeconds,
      if (repsCompleted != null) 'reps_completed': repsCompleted,
      if (rpeAchieved != null) 'rpe_achieved': rpeAchieved,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (isExtra != null) 'is_extra': isExtra,
      if (wasSkipped != null) 'was_skipped': wasSkipped,
    });
  }

  SetRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? programExerciseId,
    Value<int>? setNumber,
    Value<double?>? loadKg,
    Value<int?>? timeSeconds,
    Value<int?>? repsCompleted,
    Value<int?>? rpeAchieved,
    Value<DateTime>? recordedAt,
    Value<bool>? isExtra,
    Value<bool>? wasSkipped,
  }) {
    return SetRecordsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      programExerciseId: programExerciseId ?? this.programExerciseId,
      setNumber: setNumber ?? this.setNumber,
      loadKg: loadKg ?? this.loadKg,
      timeSeconds: timeSeconds ?? this.timeSeconds,
      repsCompleted: repsCompleted ?? this.repsCompleted,
      rpeAchieved: rpeAchieved ?? this.rpeAchieved,
      recordedAt: recordedAt ?? this.recordedAt,
      isExtra: isExtra ?? this.isExtra,
      wasSkipped: wasSkipped ?? this.wasSkipped,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (programExerciseId.present) {
      map['program_exercise_id'] = Variable<int>(programExerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (loadKg.present) {
      map['load_kg'] = Variable<double>(loadKg.value);
    }
    if (timeSeconds.present) {
      map['time_seconds'] = Variable<int>(timeSeconds.value);
    }
    if (repsCompleted.present) {
      map['reps_completed'] = Variable<int>(repsCompleted.value);
    }
    if (rpeAchieved.present) {
      map['rpe_achieved'] = Variable<int>(rpeAchieved.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (isExtra.present) {
      map['is_extra'] = Variable<bool>(isExtra.value);
    }
    if (wasSkipped.present) {
      map['was_skipped'] = Variable<bool>(wasSkipped.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetRecordsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('programExerciseId: $programExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('loadKg: $loadKg, ')
          ..write('timeSeconds: $timeSeconds, ')
          ..write('repsCompleted: $repsCompleted, ')
          ..write('rpeAchieved: $rpeAchieved, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('isExtra: $isExtra, ')
          ..write('wasSkipped: $wasSkipped')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ProgramsTable programs = $ProgramsTable(this);
  late final $ProgramDaysTable programDays = $ProgramDaysTable(this);
  late final $ProgramExercisesTable programExercises = $ProgramExercisesTable(
    this,
  );
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $SetRecordsTable setRecords = $SetRecordsTable(this);
  late final ExercisesDao exercisesDao = ExercisesDao(this as AppDatabase);
  late final ProgramsDao programsDao = ProgramsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    exercises,
    programs,
    programDays,
    programExercises,
    workoutSessions,
    setRecords,
  ];
}

typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      required String name,
      required String muscleGroup,
      required String muscleSize,
      required String exerciseType,
      required String metricType,
      Value<String?> youtubeUrl,
      Value<double?> customIncrement,
      Value<DateTime> createdAt,
      Value<bool> isDeleted,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> muscleGroup,
      Value<String> muscleSize,
      Value<String> exerciseType,
      Value<String> metricType,
      Value<String?> youtubeUrl,
      Value<double?> customIncrement,
      Value<DateTime> createdAt,
      Value<bool> isDeleted,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProgramExercisesTable, List<ProgramExercise>>
  _programExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.programExercises,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.programExercises.exerciseId,
    ),
  );

  $$ProgramExercisesTableProcessedTableManager get programExercisesRefs {
    final manager = $$ProgramExercisesTableTableManager(
      $_db,
      $_db.programExercises,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _programExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleSize => $composableBuilder(
    column: $table.muscleSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricType => $composableBuilder(
    column: $table.metricType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get youtubeUrl => $composableBuilder(
    column: $table.youtubeUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get customIncrement => $composableBuilder(
    column: $table.customIncrement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> programExercisesRefs(
    Expression<bool> Function($$ProgramExercisesTableFilterComposer f) f,
  ) {
    final $$ProgramExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableFilterComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleSize => $composableBuilder(
    column: $table.muscleSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricType => $composableBuilder(
    column: $table.metricType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get youtubeUrl => $composableBuilder(
    column: $table.youtubeUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get customIncrement => $composableBuilder(
    column: $table.customIncrement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get muscleSize => $composableBuilder(
    column: $table.muscleSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metricType => $composableBuilder(
    column: $table.metricType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get youtubeUrl => $composableBuilder(
    column: $table.youtubeUrl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get customIncrement => $composableBuilder(
    column: $table.customIncrement,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> programExercisesRefs<T extends Object>(
    Expression<T> Function($$ProgramExercisesTableAnnotationComposer a) f,
  ) {
    final $$ProgramExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, $$ExercisesTableReferences),
          Exercise,
          PrefetchHooks Function({bool programExercisesRefs})
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> muscleGroup = const Value.absent(),
                Value<String> muscleSize = const Value.absent(),
                Value<String> exerciseType = const Value.absent(),
                Value<String> metricType = const Value.absent(),
                Value<String?> youtubeUrl = const Value.absent(),
                Value<double?> customIncrement = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                muscleGroup: muscleGroup,
                muscleSize: muscleSize,
                exerciseType: exerciseType,
                metricType: metricType,
                youtubeUrl: youtubeUrl,
                customIncrement: customIncrement,
                createdAt: createdAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String muscleGroup,
                required String muscleSize,
                required String exerciseType,
                required String metricType,
                Value<String?> youtubeUrl = const Value.absent(),
                Value<double?> customIncrement = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                muscleGroup: muscleGroup,
                muscleSize: muscleSize,
                exerciseType: exerciseType,
                metricType: metricType,
                youtubeUrl: youtubeUrl,
                customIncrement: customIncrement,
                createdAt: createdAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({programExercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (programExercisesRefs) db.programExercises,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (programExercisesRefs)
                    await $_getPrefetchedData<
                      Exercise,
                      $ExercisesTable,
                      ProgramExercise
                    >(
                      currentTable: table,
                      referencedTable: $$ExercisesTableReferences
                          ._programExercisesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExercisesTableReferences(
                            db,
                            table,
                            p0,
                          ).programExercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.exerciseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, $$ExercisesTableReferences),
      Exercise,
      PrefetchHooks Function({bool programExercisesRefs})
    >;
typedef $$ProgramsTableCreateCompanionBuilder =
    ProgramsCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$ProgramsTableUpdateCompanionBuilder =
    ProgramsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$ProgramsTableReferences
    extends BaseReferences<_$AppDatabase, $ProgramsTable, Program> {
  $$ProgramsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProgramDaysTable, List<ProgramDay>>
  _programDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.programDays,
    aliasName: $_aliasNameGenerator(db.programs.id, db.programDays.programId),
  );

  $$ProgramDaysTableProcessedTableManager get programDaysRefs {
    final manager = $$ProgramDaysTableTableManager(
      $_db,
      $_db.programDays,
    ).filter((f) => f.programId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_programDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProgramsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> programDaysRefs(
    Expression<bool> Function($$ProgramDaysTableFilterComposer f) f,
  ) {
    final $$ProgramDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.programId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableFilterComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgramsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> programDaysRefs<T extends Object>(
    Expression<T> Function($$ProgramDaysTableAnnotationComposer a) f,
  ) {
    final $$ProgramDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.programId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramsTable,
          Program,
          $$ProgramsTableFilterComposer,
          $$ProgramsTableOrderingComposer,
          $$ProgramsTableAnnotationComposer,
          $$ProgramsTableCreateCompanionBuilder,
          $$ProgramsTableUpdateCompanionBuilder,
          (Program, $$ProgramsTableReferences),
          Program,
          PrefetchHooks Function({bool programDaysRefs})
        > {
  $$ProgramsTableTableManager(_$AppDatabase db, $ProgramsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProgramsCompanion(
                id: id,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProgramsCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgramsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({programDaysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (programDaysRefs) db.programDays],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (programDaysRefs)
                    await $_getPrefetchedData<
                      Program,
                      $ProgramsTable,
                      ProgramDay
                    >(
                      currentTable: table,
                      referencedTable: $$ProgramsTableReferences
                          ._programDaysRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProgramsTableReferences(
                        db,
                        table,
                        p0,
                      ).programDaysRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.programId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProgramsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramsTable,
      Program,
      $$ProgramsTableFilterComposer,
      $$ProgramsTableOrderingComposer,
      $$ProgramsTableAnnotationComposer,
      $$ProgramsTableCreateCompanionBuilder,
      $$ProgramsTableUpdateCompanionBuilder,
      (Program, $$ProgramsTableReferences),
      Program,
      PrefetchHooks Function({bool programDaysRefs})
    >;
typedef $$ProgramDaysTableCreateCompanionBuilder =
    ProgramDaysCompanion Function({
      Value<int> id,
      required int programId,
      required String name,
      required int dayOrder,
    });
typedef $$ProgramDaysTableUpdateCompanionBuilder =
    ProgramDaysCompanion Function({
      Value<int> id,
      Value<int> programId,
      Value<String> name,
      Value<int> dayOrder,
    });

final class $$ProgramDaysTableReferences
    extends BaseReferences<_$AppDatabase, $ProgramDaysTable, ProgramDay> {
  $$ProgramDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProgramsTable _programIdTable(_$AppDatabase db) =>
      db.programs.createAlias(
        $_aliasNameGenerator(db.programDays.programId, db.programs.id),
      );

  $$ProgramsTableProcessedTableManager get programId {
    final $_column = $_itemColumn<int>('program_id')!;

    final manager = $$ProgramsTableTableManager(
      $_db,
      $_db.programs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_programIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProgramExercisesTable, List<ProgramExercise>>
  _programExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.programExercises,
    aliasName: $_aliasNameGenerator(
      db.programDays.id,
      db.programExercises.programDayId,
    ),
  );

  $$ProgramExercisesTableProcessedTableManager get programExercisesRefs {
    final manager = $$ProgramExercisesTableTableManager(
      $_db,
      $_db.programExercises,
    ).filter((f) => f.programDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _programExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutSessionsTable, List<WorkoutSession>>
  _workoutSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSessions,
    aliasName: $_aliasNameGenerator(
      db.programDays.id,
      db.workoutSessions.programDayId,
    ),
  );

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionsRefs {
    final manager = $$WorkoutSessionsTableTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.programDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProgramDaysTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramDaysTable> {
  $$ProgramDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOrder => $composableBuilder(
    column: $table.dayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProgramsTableFilterComposer get programId {
    final $$ProgramsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.programs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramsTableFilterComposer(
            $db: $db,
            $table: $db.programs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> programExercisesRefs(
    Expression<bool> Function($$ProgramExercisesTableFilterComposer f) f,
  ) {
    final $$ProgramExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.programDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableFilterComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutSessionsRefs(
    Expression<bool> Function($$WorkoutSessionsTableFilterComposer f) f,
  ) {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.programDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramDaysTable> {
  $$ProgramDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOrder => $composableBuilder(
    column: $table.dayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProgramsTableOrderingComposer get programId {
    final $$ProgramsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.programs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramsTableOrderingComposer(
            $db: $db,
            $table: $db.programs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgramDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramDaysTable> {
  $$ProgramDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get dayOrder =>
      $composableBuilder(column: $table.dayOrder, builder: (column) => column);

  $$ProgramsTableAnnotationComposer get programId {
    final $$ProgramsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.programs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramsTableAnnotationComposer(
            $db: $db,
            $table: $db.programs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> programExercisesRefs<T extends Object>(
    Expression<T> Function($$ProgramExercisesTableAnnotationComposer a) f,
  ) {
    final $$ProgramExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.programDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutSessionsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSessionsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.programDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramDaysTable,
          ProgramDay,
          $$ProgramDaysTableFilterComposer,
          $$ProgramDaysTableOrderingComposer,
          $$ProgramDaysTableAnnotationComposer,
          $$ProgramDaysTableCreateCompanionBuilder,
          $$ProgramDaysTableUpdateCompanionBuilder,
          (ProgramDay, $$ProgramDaysTableReferences),
          ProgramDay,
          PrefetchHooks Function({
            bool programId,
            bool programExercisesRefs,
            bool workoutSessionsRefs,
          })
        > {
  $$ProgramDaysTableTableManager(_$AppDatabase db, $ProgramDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> programId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> dayOrder = const Value.absent(),
              }) => ProgramDaysCompanion(
                id: id,
                programId: programId,
                name: name,
                dayOrder: dayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int programId,
                required String name,
                required int dayOrder,
              }) => ProgramDaysCompanion.insert(
                id: id,
                programId: programId,
                name: name,
                dayOrder: dayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgramDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                programId = false,
                programExercisesRefs = false,
                workoutSessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (programExercisesRefs) db.programExercises,
                    if (workoutSessionsRefs) db.workoutSessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (programId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.programId,
                                    referencedTable:
                                        $$ProgramDaysTableReferences
                                            ._programIdTable(db),
                                    referencedColumn:
                                        $$ProgramDaysTableReferences
                                            ._programIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (programExercisesRefs)
                        await $_getPrefetchedData<
                          ProgramDay,
                          $ProgramDaysTable,
                          ProgramExercise
                        >(
                          currentTable: table,
                          referencedTable: $$ProgramDaysTableReferences
                              ._programExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProgramDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).programExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.programDayId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutSessionsRefs)
                        await $_getPrefetchedData<
                          ProgramDay,
                          $ProgramDaysTable,
                          WorkoutSession
                        >(
                          currentTable: table,
                          referencedTable: $$ProgramDaysTableReferences
                              ._workoutSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProgramDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.programDayId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProgramDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramDaysTable,
      ProgramDay,
      $$ProgramDaysTableFilterComposer,
      $$ProgramDaysTableOrderingComposer,
      $$ProgramDaysTableAnnotationComposer,
      $$ProgramDaysTableCreateCompanionBuilder,
      $$ProgramDaysTableUpdateCompanionBuilder,
      (ProgramDay, $$ProgramDaysTableReferences),
      ProgramDay,
      PrefetchHooks Function({
        bool programId,
        bool programExercisesRefs,
        bool workoutSessionsRefs,
      })
    >;
typedef $$ProgramExercisesTableCreateCompanionBuilder =
    ProgramExercisesCompanion Function({
      Value<int> id,
      required int programDayId,
      required int exerciseId,
      required int exerciseOrder,
      required int sets,
      required int repMin,
      required int repMax,
      Value<int?> rpeTarget,
      Value<int> restSeconds,
    });
typedef $$ProgramExercisesTableUpdateCompanionBuilder =
    ProgramExercisesCompanion Function({
      Value<int> id,
      Value<int> programDayId,
      Value<int> exerciseId,
      Value<int> exerciseOrder,
      Value<int> sets,
      Value<int> repMin,
      Value<int> repMax,
      Value<int?> rpeTarget,
      Value<int> restSeconds,
    });

final class $$ProgramExercisesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProgramExercisesTable, ProgramExercise> {
  $$ProgramExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProgramDaysTable _programDayIdTable(_$AppDatabase db) =>
      db.programDays.createAlias(
        $_aliasNameGenerator(
          db.programExercises.programDayId,
          db.programDays.id,
        ),
      );

  $$ProgramDaysTableProcessedTableManager get programDayId {
    final $_column = $_itemColumn<int>('program_day_id')!;

    final manager = $$ProgramDaysTableTableManager(
      $_db,
      $_db.programDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_programDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.programExercises.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SetRecordsTable, List<SetRecord>>
  _setRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.setRecords,
    aliasName: $_aliasNameGenerator(
      db.programExercises.id,
      db.setRecords.programExerciseId,
    ),
  );

  $$SetRecordsTableProcessedTableManager get setRecordsRefs {
    final manager = $$SetRecordsTableTableManager(
      $_db,
      $_db.setRecords,
    ).filter((f) => f.programExerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_setRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProgramExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramExercisesTable> {
  $$ProgramExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repMin => $composableBuilder(
    column: $table.repMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repMax => $composableBuilder(
    column: $table.repMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rpeTarget => $composableBuilder(
    column: $table.rpeTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  $$ProgramDaysTableFilterComposer get programDayId {
    final $$ProgramDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programDayId,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableFilterComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> setRecordsRefs(
    Expression<bool> Function($$SetRecordsTableFilterComposer f) f,
  ) {
    final $$SetRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setRecords,
      getReferencedColumn: (t) => t.programExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetRecordsTableFilterComposer(
            $db: $db,
            $table: $db.setRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramExercisesTable> {
  $$ProgramExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repMin => $composableBuilder(
    column: $table.repMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repMax => $composableBuilder(
    column: $table.repMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rpeTarget => $composableBuilder(
    column: $table.rpeTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProgramDaysTableOrderingComposer get programDayId {
    final $$ProgramDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programDayId,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableOrderingComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgramExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramExercisesTable> {
  $$ProgramExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get repMin =>
      $composableBuilder(column: $table.repMin, builder: (column) => column);

  GeneratedColumn<int> get repMax =>
      $composableBuilder(column: $table.repMax, builder: (column) => column);

  GeneratedColumn<int> get rpeTarget =>
      $composableBuilder(column: $table.rpeTarget, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  $$ProgramDaysTableAnnotationComposer get programDayId {
    final $$ProgramDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programDayId,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> setRecordsRefs<T extends Object>(
    Expression<T> Function($$SetRecordsTableAnnotationComposer a) f,
  ) {
    final $$SetRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setRecords,
      getReferencedColumn: (t) => t.programExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.setRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramExercisesTable,
          ProgramExercise,
          $$ProgramExercisesTableFilterComposer,
          $$ProgramExercisesTableOrderingComposer,
          $$ProgramExercisesTableAnnotationComposer,
          $$ProgramExercisesTableCreateCompanionBuilder,
          $$ProgramExercisesTableUpdateCompanionBuilder,
          (ProgramExercise, $$ProgramExercisesTableReferences),
          ProgramExercise,
          PrefetchHooks Function({
            bool programDayId,
            bool exerciseId,
            bool setRecordsRefs,
          })
        > {
  $$ProgramExercisesTableTableManager(
    _$AppDatabase db,
    $ProgramExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> programDayId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> exerciseOrder = const Value.absent(),
                Value<int> sets = const Value.absent(),
                Value<int> repMin = const Value.absent(),
                Value<int> repMax = const Value.absent(),
                Value<int?> rpeTarget = const Value.absent(),
                Value<int> restSeconds = const Value.absent(),
              }) => ProgramExercisesCompanion(
                id: id,
                programDayId: programDayId,
                exerciseId: exerciseId,
                exerciseOrder: exerciseOrder,
                sets: sets,
                repMin: repMin,
                repMax: repMax,
                rpeTarget: rpeTarget,
                restSeconds: restSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int programDayId,
                required int exerciseId,
                required int exerciseOrder,
                required int sets,
                required int repMin,
                required int repMax,
                Value<int?> rpeTarget = const Value.absent(),
                Value<int> restSeconds = const Value.absent(),
              }) => ProgramExercisesCompanion.insert(
                id: id,
                programDayId: programDayId,
                exerciseId: exerciseId,
                exerciseOrder: exerciseOrder,
                sets: sets,
                repMin: repMin,
                repMax: repMax,
                rpeTarget: rpeTarget,
                restSeconds: restSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgramExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                programDayId = false,
                exerciseId = false,
                setRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (setRecordsRefs) db.setRecords],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (programDayId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.programDayId,
                                    referencedTable:
                                        $$ProgramExercisesTableReferences
                                            ._programDayIdTable(db),
                                    referencedColumn:
                                        $$ProgramExercisesTableReferences
                                            ._programDayIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (exerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.exerciseId,
                                    referencedTable:
                                        $$ProgramExercisesTableReferences
                                            ._exerciseIdTable(db),
                                    referencedColumn:
                                        $$ProgramExercisesTableReferences
                                            ._exerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (setRecordsRefs)
                        await $_getPrefetchedData<
                          ProgramExercise,
                          $ProgramExercisesTable,
                          SetRecord
                        >(
                          currentTable: table,
                          referencedTable: $$ProgramExercisesTableReferences
                              ._setRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProgramExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).setRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.programExerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProgramExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramExercisesTable,
      ProgramExercise,
      $$ProgramExercisesTableFilterComposer,
      $$ProgramExercisesTableOrderingComposer,
      $$ProgramExercisesTableAnnotationComposer,
      $$ProgramExercisesTableCreateCompanionBuilder,
      $$ProgramExercisesTableUpdateCompanionBuilder,
      (ProgramExercise, $$ProgramExercisesTableReferences),
      ProgramExercise,
      PrefetchHooks Function({
        bool programDayId,
        bool exerciseId,
        bool setRecordsRefs,
      })
    >;
typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<int> id,
      required int programDayId,
      required DateTime startedAt,
      Value<DateTime?> finishedAt,
      Value<String> status,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<int> id,
      Value<int> programDayId,
      Value<DateTime> startedAt,
      Value<DateTime?> finishedAt,
      Value<String> status,
    });

final class $$WorkoutSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession> {
  $$WorkoutSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProgramDaysTable _programDayIdTable(_$AppDatabase db) =>
      db.programDays.createAlias(
        $_aliasNameGenerator(
          db.workoutSessions.programDayId,
          db.programDays.id,
        ),
      );

  $$ProgramDaysTableProcessedTableManager get programDayId {
    final $_column = $_itemColumn<int>('program_day_id')!;

    final manager = $$ProgramDaysTableTableManager(
      $_db,
      $_db.programDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_programDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SetRecordsTable, List<SetRecord>>
  _setRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.setRecords,
    aliasName: $_aliasNameGenerator(
      db.workoutSessions.id,
      db.setRecords.sessionId,
    ),
  );

  $$SetRecordsTableProcessedTableManager get setRecordsRefs {
    final manager = $$SetRecordsTableTableManager(
      $_db,
      $_db.setRecords,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_setRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$ProgramDaysTableFilterComposer get programDayId {
    final $$ProgramDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programDayId,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableFilterComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> setRecordsRefs(
    Expression<bool> Function($$SetRecordsTableFilterComposer f) f,
  ) {
    final $$SetRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setRecords,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetRecordsTableFilterComposer(
            $db: $db,
            $table: $db.setRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProgramDaysTableOrderingComposer get programDayId {
    final $$ProgramDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programDayId,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableOrderingComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$ProgramDaysTableAnnotationComposer get programDayId {
    final $$ProgramDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programDayId,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> setRecordsRefs<T extends Object>(
    Expression<T> Function($$SetRecordsTableAnnotationComposer a) f,
  ) {
    final $$SetRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setRecords,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.setRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSession,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (WorkoutSession, $$WorkoutSessionsTableReferences),
          WorkoutSession,
          PrefetchHooks Function({bool programDayId, bool setRecordsRefs})
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> programDayId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                programDayId: programDayId,
                startedAt: startedAt,
                finishedAt: finishedAt,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int programDayId,
                required DateTime startedAt,
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                programDayId: programDayId,
                startedAt: startedAt,
                finishedAt: finishedAt,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({programDayId = false, setRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (setRecordsRefs) db.setRecords],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (programDayId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.programDayId,
                                    referencedTable:
                                        $$WorkoutSessionsTableReferences
                                            ._programDayIdTable(db),
                                    referencedColumn:
                                        $$WorkoutSessionsTableReferences
                                            ._programDayIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (setRecordsRefs)
                        await $_getPrefetchedData<
                          WorkoutSession,
                          $WorkoutSessionsTable,
                          SetRecord
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutSessionsTableReferences
                              ._setRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).setRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSession,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (WorkoutSession, $$WorkoutSessionsTableReferences),
      WorkoutSession,
      PrefetchHooks Function({bool programDayId, bool setRecordsRefs})
    >;
typedef $$SetRecordsTableCreateCompanionBuilder =
    SetRecordsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int programExerciseId,
      required int setNumber,
      Value<double?> loadKg,
      Value<int?> timeSeconds,
      Value<int?> repsCompleted,
      Value<int?> rpeAchieved,
      Value<DateTime> recordedAt,
      Value<bool> isExtra,
      Value<bool> wasSkipped,
    });
typedef $$SetRecordsTableUpdateCompanionBuilder =
    SetRecordsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> programExerciseId,
      Value<int> setNumber,
      Value<double?> loadKg,
      Value<int?> timeSeconds,
      Value<int?> repsCompleted,
      Value<int?> rpeAchieved,
      Value<DateTime> recordedAt,
      Value<bool> isExtra,
      Value<bool> wasSkipped,
    });

final class $$SetRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $SetRecordsTable, SetRecord> {
  $$SetRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.workoutSessions.createAlias(
        $_aliasNameGenerator(db.setRecords.sessionId, db.workoutSessions.id),
      );

  $$WorkoutSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$WorkoutSessionsTableTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProgramExercisesTable _programExerciseIdTable(_$AppDatabase db) =>
      db.programExercises.createAlias(
        $_aliasNameGenerator(
          db.setRecords.programExerciseId,
          db.programExercises.id,
        ),
      );

  $$ProgramExercisesTableProcessedTableManager get programExerciseId {
    final $_column = $_itemColumn<int>('program_exercise_id')!;

    final manager = $$ProgramExercisesTableTableManager(
      $_db,
      $_db.programExercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_programExerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SetRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SetRecordsTable> {
  $$SetRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get loadKg => $composableBuilder(
    column: $table.loadKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeSeconds => $composableBuilder(
    column: $table.timeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repsCompleted => $composableBuilder(
    column: $table.repsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rpeAchieved => $composableBuilder(
    column: $table.rpeAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isExtra => $composableBuilder(
    column: $table.isExtra,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasSkipped => $composableBuilder(
    column: $table.wasSkipped,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutSessionsTableFilterComposer get sessionId {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProgramExercisesTableFilterComposer get programExerciseId {
    final $$ProgramExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programExerciseId,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableFilterComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SetRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetRecordsTable> {
  $$SetRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get loadKg => $composableBuilder(
    column: $table.loadKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeSeconds => $composableBuilder(
    column: $table.timeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repsCompleted => $composableBuilder(
    column: $table.repsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rpeAchieved => $composableBuilder(
    column: $table.rpeAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExtra => $composableBuilder(
    column: $table.isExtra,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasSkipped => $composableBuilder(
    column: $table.wasSkipped,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutSessionsTableOrderingComposer get sessionId {
    final $$WorkoutSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProgramExercisesTableOrderingComposer get programExerciseId {
    final $$ProgramExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programExerciseId,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SetRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetRecordsTable> {
  $$SetRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get loadKg =>
      $composableBuilder(column: $table.loadKg, builder: (column) => column);

  GeneratedColumn<int> get timeSeconds => $composableBuilder(
    column: $table.timeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repsCompleted => $composableBuilder(
    column: $table.repsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rpeAchieved => $composableBuilder(
    column: $table.rpeAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isExtra =>
      $composableBuilder(column: $table.isExtra, builder: (column) => column);

  GeneratedColumn<bool> get wasSkipped => $composableBuilder(
    column: $table.wasSkipped,
    builder: (column) => column,
  );

  $$WorkoutSessionsTableAnnotationComposer get sessionId {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProgramExercisesTableAnnotationComposer get programExerciseId {
    final $$ProgramExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programExerciseId,
      referencedTable: $db.programExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.programExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SetRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SetRecordsTable,
          SetRecord,
          $$SetRecordsTableFilterComposer,
          $$SetRecordsTableOrderingComposer,
          $$SetRecordsTableAnnotationComposer,
          $$SetRecordsTableCreateCompanionBuilder,
          $$SetRecordsTableUpdateCompanionBuilder,
          (SetRecord, $$SetRecordsTableReferences),
          SetRecord,
          PrefetchHooks Function({bool sessionId, bool programExerciseId})
        > {
  $$SetRecordsTableTableManager(_$AppDatabase db, $SetRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> programExerciseId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<double?> loadKg = const Value.absent(),
                Value<int?> timeSeconds = const Value.absent(),
                Value<int?> repsCompleted = const Value.absent(),
                Value<int?> rpeAchieved = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<bool> isExtra = const Value.absent(),
                Value<bool> wasSkipped = const Value.absent(),
              }) => SetRecordsCompanion(
                id: id,
                sessionId: sessionId,
                programExerciseId: programExerciseId,
                setNumber: setNumber,
                loadKg: loadKg,
                timeSeconds: timeSeconds,
                repsCompleted: repsCompleted,
                rpeAchieved: rpeAchieved,
                recordedAt: recordedAt,
                isExtra: isExtra,
                wasSkipped: wasSkipped,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int programExerciseId,
                required int setNumber,
                Value<double?> loadKg = const Value.absent(),
                Value<int?> timeSeconds = const Value.absent(),
                Value<int?> repsCompleted = const Value.absent(),
                Value<int?> rpeAchieved = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<bool> isExtra = const Value.absent(),
                Value<bool> wasSkipped = const Value.absent(),
              }) => SetRecordsCompanion.insert(
                id: id,
                sessionId: sessionId,
                programExerciseId: programExerciseId,
                setNumber: setNumber,
                loadKg: loadKg,
                timeSeconds: timeSeconds,
                repsCompleted: repsCompleted,
                rpeAchieved: rpeAchieved,
                recordedAt: recordedAt,
                isExtra: isExtra,
                wasSkipped: wasSkipped,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SetRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sessionId = false, programExerciseId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable: $$SetRecordsTableReferences
                                        ._sessionIdTable(db),
                                    referencedColumn:
                                        $$SetRecordsTableReferences
                                            ._sessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (programExerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.programExerciseId,
                                    referencedTable: $$SetRecordsTableReferences
                                        ._programExerciseIdTable(db),
                                    referencedColumn:
                                        $$SetRecordsTableReferences
                                            ._programExerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SetRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SetRecordsTable,
      SetRecord,
      $$SetRecordsTableFilterComposer,
      $$SetRecordsTableOrderingComposer,
      $$SetRecordsTableAnnotationComposer,
      $$SetRecordsTableCreateCompanionBuilder,
      $$SetRecordsTableUpdateCompanionBuilder,
      (SetRecord, $$SetRecordsTableReferences),
      SetRecord,
      PrefetchHooks Function({bool sessionId, bool programExerciseId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db, _db.programs);
  $$ProgramDaysTableTableManager get programDays =>
      $$ProgramDaysTableTableManager(_db, _db.programDays);
  $$ProgramExercisesTableTableManager get programExercises =>
      $$ProgramExercisesTableTableManager(_db, _db.programExercises);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$SetRecordsTableTableManager get setRecords =>
      $$SetRecordsTableTableManager(_db, _db.setRecords);
}
