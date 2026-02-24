import 'package:drift/drift.dart';

/// Tabela de exercícios.
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get muscleGroup => text()();
  TextColumn get muscleSize => text()();
  TextColumn get exerciseType => text()();
  TextColumn get metricType => text()();
  TextColumn get youtubeUrl => text().nullable()();
  RealColumn get customIncrement => real().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
