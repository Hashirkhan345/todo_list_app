import 'package:todo_list_app/my_todo/data/enum/query_type.dart';
import 'package:todo_list_app/my_todo/data/model/task.dart';
import 'package:todo_list_app/my_todo/data/repository/db_helper.dart';
import 'package:todo_list_app/my_todo/data/repository/my_todo_repository/list_todo.dart';

// for completed & inComplete Task & all Task....
final taskController = TasksController();

late Future<List<Task>> task;
final DatabaseHelper databaseHelper = DatabaseHelper.instance;
QueryType queryType = QueryType.incompleteTasks;
QueryType listType = QueryType.allTasks;

QueryType getQuery() {
  if (queryType == QueryType.completedTasks) {
    taskController.getCompletedTasks();
  } else if (queryType == QueryType.incompleteTasks) {
    taskController.getIncompleteTasks();
  } else {
    taskController.getAllTasks();
  }
  return getQuery();
}
