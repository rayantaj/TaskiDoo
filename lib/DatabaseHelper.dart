import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  DatabaseHelper.privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();
  static final dbName = 'myDatabase2.db';
  static final dbVersion = 1;

  static Database _database;

  static final tableName = 'Tasks3';
  static final colID = 'id';
  static final colTitle = 'title';
  static final colDesc = 'description';
  static final colFlag = 'flag';
  static final colDate = 'date';

  Future<Database> get database async {
    if (_database != null)
      return _database;


      _database = await initiateDatabase();
      return _database;
  }

  // Future<Database> getDatabase()async {
  //   if (_database != null)
  //     return _database;
  //   else
  //    return _database = await initiateDatabase();
  // }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
   // print(directory);

    String path = join(directory.path, dbName);
    // print(path);
    return await openDatabase(path, version: dbVersion, onCreate: onCreateDatabase);

  }

  Future onCreateDatabase(Database db, int version) {
    db.execute('''
    
    CREATE TABLE $tableName (
    
    $colID INTEGER PRIMARY KEY , 
    $colTitle TEXT NOT NULL , 
    $colDesc TEXT , 
    $colDate TEXT , 
    $colFlag INTEGER
     );
    ''');

  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
print(db==null);
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;

    return await db.query(tableName);
  }
}
