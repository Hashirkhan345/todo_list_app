import '../../../data/repository/db_helper.dart';
import 'package:todo_list_app/my_todo/data/model/task.dart';

class TasksController1 {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<bool> insertTask({required Task newTask}) async {
    final result = await databaseHelper.insert(newTask);
    // final result = await databaseHelper.insert(newTask);
    return result != 0;
  }
}
