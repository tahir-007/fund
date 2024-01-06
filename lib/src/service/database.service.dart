import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  late Dio dio;
  late Database db;

  DataService() {
    dio = Dio();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'database.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Projects (
            Id INTEGER PRIMARY KEY,
            title TEXT,
            shortDescription TEXT,
            collectedValue INTEGER,
            totalValue INTEGER,
            startDate TEXT,
            endDate TEXT,
            mainImageURL TEXT
          )
        ''');

        // Fetch and insert data only if the table is empty
        if (await isTableEmpty(db)) {
          try {
            final response = await dio
                .get('https://testffc.nimapinfotech.com/testdata.json');
            final projects = response.data['data']['Records'];
            await insertProjects(projects, db);

            // Show success alert
          } catch (error) {
            Exception('Error fetching or inserting data: $error');
            // Handle the error, you might want to show a message to the user.
          }
        }
      },
    );
  }

  Future<bool> isTableEmpty(Database db) async {
    final result = await db.rawQuery('SELECT COUNT(*) FROM Projects');
    return Sqflite.firstIntValue(result) == 0;
  }

  Future<List<Map<String, dynamic>>> getProjects() async {
    // Ensure that the 'db' field has been initialized before using it
    await initDatabase();
    return await db.query('Projects');
  }

  Future<void> insertProjects(List projects, Database db) async {
    // Ensure that the 'db' field has been initialized before using it
    for (var project in projects) {
      await db.insert('Projects', project);
    }
  }
}
