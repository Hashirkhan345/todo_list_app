


import 'package:todo_list_app/my_todo/data/repository/db_helper.dart';

class TasksController {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
Future<int> delete(int id) async {
  final int result = await databaseHelper.delete(id);
  return result;
}}