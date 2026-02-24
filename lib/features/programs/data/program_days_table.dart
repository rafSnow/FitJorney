import 'package:drift/drift.dart';

import 'programs_table.dart';

/// Tabela de dias de um programa.
class ProgramDays extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get programId => integer().references(Programs, #id)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get dayOrder => integer()();
}
