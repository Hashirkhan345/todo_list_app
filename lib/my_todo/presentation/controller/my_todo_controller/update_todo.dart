import 'package:flutter/foundation.dart';
import 'package:todo_list_app/my_todo/data/enum/query_type.dart';
import 'package:todo_list_app/my_todo/data/model/task.dart';
import 'package:todo_list_app/my_todo/data/repository/db_helper.dart';

class TasksController{
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> update(Task task) async {
    final int result = await databaseHelper.update(task);
    return result;
  }
}
