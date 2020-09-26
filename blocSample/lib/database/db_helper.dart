import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:blocSample/model/lap.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  static Database _db;

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<bool> openDb() async {
    if (_db == null) {
      print("openning db pls wait");
      var dbPath = join(await getDatabasesPath(), 'lappie_database.db');
      _db = await openDatabase(dbPath, version: 1, onCreate: _createDb);
      print("done openning db");
    }
    return (_db != null);
  }

  void _createDb(Database db, int newVersion) async {
    await _db.execute("CREATE TABLE laps ("
        "order INTEGER PRIMARY KEY,"
        "minute INTEGER,"
        "second INTEGER,"
        "centisecond INTEGER"
        ")");
  }

  Future<void> insertLap(Lap lap) async {
    await _db.insert(
      'laps',
      lap.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Lap>> laps() async {
    // Query the table for all The laps.
    final List<Map<String, dynamic>> maps =
        await _db.rawQuery("SELECT * FROM laps ORDER BY order ASC");

    // Convert the List<Map<String, dynamic> into a List<lap>.
    return List.generate(maps.length, (i) {
      return Lap(
          order: maps[i]['order'],
          minute: maps[i]['minute'],
          second: maps[i]['second'],
          centisecond: maps[i]['centisecond']);
    });
  }

  Future<int> getCurrentOrder() async {
    final List<Map<String, dynamic>> currentLaps =
        await _db.rawQuery("SELECT * FROM laps ORDER BY order DESC");
    var lastLaps = currentLaps.first;
    return lastLaps['order'] ?? 0;
  }

  Future<void> updatelap(Lap lap) async {
    // Update the given lap.
    await _db.update(
      'laps',
      lap.toMap(),
      // Ensure that the lap has a matching id.
      where: "order = ?",
      // Pass the lap's id as a whereArg to prevent SQL injection.
      whereArgs: [lap.order],
    );
  }

  Future<void> deletelap(int order) async {
    // Remove the lap from the database.
    await _db.delete(
      'laps',
      // Use a `where` clause to delete a specific lap.
      where: "order = ?",
      // Pass the lap's id as a whereArg to prevent SQL injection.
      whereArgs: [order],
    );
  }

  Future<void> deleteTable() async {
    await _db.execute("DELETE FROM laps");
  }
}

// void main() async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   final Future<Database> database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'lappie_database.db'),
//     // When the database is first created, create a table to store laps.
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE laps(order INTEGER PRIMARY KEY, minute INTEGER, second INTEGER, centisecond INTEGER)",
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );

//   Future<void> insertLap(Lap lap) async {
//     // Get a reference to the database.
//     final Database db = await database;

//     // Insert the lap into the correct table. Also specify the
//     // `conflictAlgorithm`. In this case, if the same lap is inserted
//     // multiple times, it replaces the previous data.
//     await db.insert(
//       'laps',
//       lap.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Lap>> laps() async {
//     // Get a reference to the database.
//     final Database db = await database;

//     // Query the table for all The laps.
//     final List<Map<String, dynamic>> maps = await db.query('laps');

//     // Convert the List<Map<String, dynamic> into a List<lap>.
//     return List.generate(maps.length, (i) {
//       return Lap(
//           order: maps[i]['order'],
//           minute: maps[i]['minute'],
//           second: maps[i]['second'],
//           centisecond: maps[i]['centisecond']);
//     });
//   }

//   Future<void> updatelap(Lap lap) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Update the given lap.
//     await db.update(
//       'laps',
//       lap.toMap(),
//       // Ensure that the lap has a matching id.
//       where: "order = ?",
//       // Pass the lap's id as a whereArg to prevent SQL injection.
//       whereArgs: [lap.order],
//     );
//   }

//   Future<void> deletelap(int order) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Remove the lap from the database.
//     await db.delete(
//       'laps',
//       // Use a `where` clause to delete a specific lap.
//       where: "order = ?",
//       // Pass the lap's id as a whereArg to prevent SQL injection.
//       whereArgs: [order],
//     );
//   }

//   // Print the list of laps (empty).
//   print(await laps());
// }
