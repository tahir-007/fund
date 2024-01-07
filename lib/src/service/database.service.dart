import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fund/src/model/project.model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  late Dio dio;
  late Database db;

  // Constructor initializes Dio and calls the method to initialize the database
  DataService() {
    dio = Dio();
    initDatabase();
  }

  // Method to initialize the SQLite database
  Future<void> initDatabase() async {
    // Get the application documents directory to store the database
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'database.db');

    // Open the database or create it if not exists
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create a 'Project' table in the database if not exists
        await db.execute('''
          CREATE TABLE Project (
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

        // Fetch data from a remote source and insert it into the 'Project' table
        if (await isTableEmpty(db)) {
          try {
            final response = await dio
                .get('https://testffc.nimapinfotech.com/testdata.json');
            final projects = response.data['data']['Records'];
            await insertProjects(projects, db);
          } catch (error) {
            Exception('Error fetching or inserting data: $error');
          }
        }
      },
    );
  }

  // Method to check if the 'Project' table is empty
  Future<bool> isTableEmpty(Database db) async {
    final result = await db.rawQuery('SELECT COUNT(*) FROM Project');
    return Sqflite.firstIntValue(result) == 0;
  }

  // Method to get a list of projects from the 'Project' table
  Future<List<Project>> getProjects() async {
    await initDatabase();
    final List<Map<String, dynamic>> projectMaps = await db.query('Project');
    return projectMaps.map((map) => Project.fromJson(map)).toList();
  }

  // Method to insert a list of projects into the 'Project' table
  Future<void> insertProjects(List projects, Database db) async {
    for (var project in projects) {
      await db.insert('Project', project);
    }
  }
}
