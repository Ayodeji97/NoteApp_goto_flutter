import 'dart:async';

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

  // CRUD operation
  // Fetch Operation : Get all note objects from database
  Future <List<Map<String, dynamic>>>getNoteMapList () async {
      // database reference
    Database db = await this.database;

   // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');  // another way to write same things.

    return result;

  }

  // Insert Operation : Insert a note object inside the database
  Future <int> insertNote (Note note) async {
      Database db = await this.database;

      var result = await db.insert(noteTable, note.toMap());

      return result;
  }

  // Update operation : Update a note object and save it to database
  Future <int> updateNote (Note note) async{
      Database db = await this.database;

      var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);

      return result;
  }

  // Delete operation : Delete a note from database
  Future <int> deleteNote (int id) async {
      var db = await this.database;

      int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = id');

      return result;

  }

  // Get number of note in our database

  Future <int> getCount () async {
      var db = await this.database;

      List<Map<String, dynamic>> count = await db.rawQuery('SELECT COUNT (*) from $noteTable');

      int result = Sqflite.firstIntValue(count);

      return result;

  }

}