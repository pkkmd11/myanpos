import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Main local database for MyanPOS.
//
// Drift manages the SQLite database underneath.
// We will add tables such as products and sales later.
@DriftDatabase()
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Database schema version.
  //
  // Increase this number when we make database schema changes.
  @override
  int get schemaVersion => 1;
}

// Open the SQLite database connection.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Get the application's database directory.
    final directory = await getApplicationDocumentsDirectory();

    // Create the full database file path.
    final file = File(
      p.join(directory.path, 'myanpos.sqlite'),
    );

    // Open the SQLite database in the background.
    return NativeDatabase.createInBackground(file);
  });
}