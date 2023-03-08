import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

enum QueryType { allTasks, completedTasks, incompleteTasks }

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String todoTable = 'TODOTABLE';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colStatus = 'status';
  String colCreatedAt = 'createdAt';
  String colTodoType = 'todoType';

  Future<Database?> get db async {
    _db ??= await initDatabase();
    return _db;

    _db = await initDatabase();
    return null;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}$todoTable.db';
    final todoList = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoList;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $todoTable($colId Integer primary Key AutoIncrement ,$colTitle Text,$colTodoType   Text,$colDescription Text,$colStatus Integer,$colCreatedAt String)");
  }

  // for insert

  Future<int> insert(Task task) async {
    debugPrint(task.toMap().toString());
    Database? db = await this.db;
    final int result = await db!.insert(
      todoTable,
      task.toMap(),
    );

    debugPrint("result for insert: $result");
    return result;
  }

  Future<int> update(Task task) async {
    Database? db = await this.db;
    final int result = await db!.update(todoTable, task.toMap(), where: '$colId=?', whereArgs: [task.id]);

    return result;
  }

  Future<List<Map<String, dynamic>>> getRawTasks({QueryType queryType = QueryType.allTasks}) async {
    Database? db = await this.db;
    List<Map<String, dynamic>> result = [];
    //incomplete tasks

    if (queryType == QueryType.incompleteTasks) {
      result = await db!.query(todoTable, where: '$colStatus=?', whereArgs: [0]);
    }
    // completed task
    else if (queryType == QueryType.completedTasks) {
      result = await db!.query(todoTable, where: '$colStatus=?', whereArgs: [1]);
    }
    //all tasks
    else {
      result = await db!.query(todoTable);
    }

    return result;
  }

  Future<Map<String, Object?>?> getLastTodoTask() async {
    Database? db = await this.db;
    final lastEntry = await db?.rawQuery('SELECT * FROM $todoTable WHERE status = 1 ORDER BY $colId ASC LIMIT 10;');
    if (kDebugMode) {
      print(lastEntry);
    }
    if (lastEntry?.isNotEmpty ?? false) {

      return lastEntry?.last;
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(todoTable, where: '$colId=?', whereArgs: [id]);
    if (kDebugMode) {
      print("your task will be deleted: $result");
    }
    return result;
  }
}
