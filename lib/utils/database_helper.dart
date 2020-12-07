import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_app_goto/models/note.dart';

/*
* Creating database helper and singletons  responsible for CRUD operation */
class DatabaseHelper {

    static DatabaseHelper _databaseHelper;    //  Singleton DatabaseHelper
    static Database _database;    // Singleton Database

    // Define the database along with the database table name
    String noteTable = 'note_table';
    String colId = 'id';
    String colTitle = 'title';
    String colDescription = 'description';
    String colPriority = 'priority';
    String colDate = 'date';



    DatabaseHelper._createInstance(); // named constructor to create instance of DatabaseHelper
    factory DatabaseHelper () {
      // initialise object
      if (_databaseHelper == null) {
        _databaseHelper = DatabaseHelper._createInstance();  // This is executed only once
      }
      return _databaseHelper;
    }

    // Creating get for database
    Future <Database> get database async {
      if (_database == null) {
        _database = await initializeDatabase();
      }

      return _database;
    }

    // function to initialize database
    Future<Database>initializeDatabase() async {
      // Get the directory path for both Android and iOS to store database
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + 'notes.db';

      // open or create the database at a given path
      var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

      return notesDatabase;



}

    // function to help create database
  void _createDb (Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
    '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

}