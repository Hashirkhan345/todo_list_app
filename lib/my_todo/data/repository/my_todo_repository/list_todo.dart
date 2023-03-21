import 'package:flutter/foundation.dart';
import 'package:todo_list_app/my_todo/data/enum/query_type.dart';
import 'package:todo_list_app/my_todo/data/model/task.dart';
import 'package:todo_list_app/my_todo/data/repository/db_helper.dart';

class TasksController {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<List<Task>> getTasks(QueryType listType) async {
    if (listType == QueryType.completedTasks) {
      return await getCompletedTasks();
    } else if (listType == QueryType.incompleteTasks) {
      return await getIncompleteTasks();
    } else {
      return await getAllTasks();
    }
  }

  Future<List<Task>> getAllTasks() async {
    final taskMapList = await databaseHelper.getRawTasks();
    final List<Task> tasks = [];

    try {
      for (var taskMap in taskMapList) {
        tasks.add(Task.fromMap(taskMap));
      }
      tasks.sort((taskA, taskB) => taskA.createdAt.compareTo(taskB.createdAt));
      if (kDebugMode) {
        print(tasks.length);
      }
    } catch (e) {
      debugPrint(" the error occurred at allTasks $e");
    }

    return tasks;
  }

  Future<Task?> getLastTask() async {
    final rawTask = await databaseHelper.getLastTodoTask();
    if (rawTask != null) {
      try {
        final task = Task.fromMap(rawTask);
        return task;
      } catch (_) {}
    }

    return null;
  }

  Future<List<Task>> getIncompleteTasks() async {
    final taskMapList = await databaseHelper.getRawTasks(queryType: QueryType.incompleteTasks);
    final List<Task> task = [];
    try {
      for (var taskMap in taskMapList) {
        task.add(Task.fromMap(taskMap));
      }
      task.sort((taskA, taskB) => taskA.createdAt.compareTo(taskB.createdAt));
    } catch (e) {
      debugPrint("error occurred at getIncompleteTasks $e");
    }
    return task;
  }

  Future<List<Task>> getCompletedTasks() async {
    final taskMapList = await databaseHelper.getRawTasks(queryType: QueryType.completedTasks);
    final List<Task> task = [];

    try {
      for (var taskMap in taskMapList) {
        task.add(Task.fromMap(taskMap));
      }
      task.sort((taskA, taskB) => taskA.createdAt.compareTo(taskB.createdAt));
    } catch (e) {
      debugPrint("error occurred at getCompletedTasks $e");
    }
    return task;
  }

  Future<int> onTaskDone(Task task) async {
    final updatedTask = task.copyWith(1);
    final id = await update(updatedTask);
    return id;
  }

  Future<bool> insertTask({required Task newTask}) async {
    final result = await databaseHelper.insert(newTask);
    // final result = await databaseHelper.insert(newTask);
    return result != 0;
  }

  Future<int> delete(int id) async {
    final int result = await databaseHelper.delete(id);
    return result;
  }

  Future<int> update(Task task) async {
    final int result = await databaseHelper.update(task);
    return result;
  }
}
