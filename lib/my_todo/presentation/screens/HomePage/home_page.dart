// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todo_list_app/my_todo/data/enum/query_type.dart';
import 'package:todo_list_app/my_todo/data/model/task.dart';
import 'package:todo_list_app/my_todo/data/repository/my_todo_repository/add_todo.dart';
import 'package:todo_list_app/my_todo/presentation/widgets/challenge_container_widget.dart';

import 'package:todo_list_app/utils/app_colors.dart';
import 'package:todo_list_app/utils/app_data.dart';
import 'package:todo_list_app/utils/text_styles.dart';

import '../../../data/repository/my_todo_repository/list_todo.dart';
import 'add_items.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownValue = 'Educational';
  final _taskController = TasksController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageColors,
      appBar: buildAppBar(),
      drawer: Drawer(
        backgroundColor: AppColors.backgroundColor,
        shape:
            const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: AppColors.splashContainer,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
              child: Center(
                child: Text(
                  "My Todo",
                  style: TextStyles.subtitle1,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  listType = QueryType.completedTasks;
                  Navigator.pop(context);
                });
              },
              title: const Text(
                "Completed Tasks",
                style: TextStyles.title,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  listType = QueryType.incompleteTasks;
                  Navigator.pop(context);
                });
              },
              title: const Text(
                "inCompleted Tasks",
                style: TextStyles.title,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  listType = QueryType.allTasks;
                  Navigator.pop(context);
                });
              },
              title: const Text(
                "All Tasks",
                style: TextStyles.title,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isInserted = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddItems()));
          if (isInserted == true) {
            if (kDebugMode) {
              print("Successfully Inserted");
            }
            //  Todo:// refresh UI

            setState(() {});
          } else {
            if (kDebugMode) {
              print("no inserted");
            }
          }
        },
        backgroundColor: AppColors.splashContainer,
        child: Container(
          height: 80,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.splashContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: AppColors.backgroundColor,
              size: 30,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // for completed task container.
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FutureBuilder<Task?>(
                future: taskController.getLastTask(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final lastTask = snapshot.data;
                  if (lastTask == null || listType != QueryType.allTasks) return SizedBox.shrink();
                  return ChallengeContainer(
                    description: lastTask.description,
                    createdAt: lastTask.createdAt.toString(),
                    title: lastTask.title,
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),

          // for remaining tasks
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: taskController.getTasks(listType),
              // taskController.getAllTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError || snapshot.data?.isEmpty == true || snapshot.data == null) {
                  return const Text("no results found");
                }
                final tasks = snapshot.data ?? [];
                if (listType != QueryType.completedTasks) {
                  tasks.retainWhere((element) => element.status == 0);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            listType == QueryType.completedTasks ? "Completed Tasks" : "Remaining Tasks",
                            style: TextStyles.title,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "(${tasks.length})",
                            style: TextStyles.subtitle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
                          itemBuilder: (context, index) => taskData(
                                context: context,
                                task: tasks[index],
                              ),
                          itemCount: tasks.length,
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(
                                height: 15,
                              )),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "My Todo",
        style: TextStyles.subtitle,
      ),
      centerTitle: true,
      backgroundColor: AppColors.homePageColors,
      elevation: 0,
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: AppColors.menuColor,
          ),
        );
      }),
      actions: [
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert_sharp,
            color: AppColors.menuColor,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                setState(() {
                  listType = QueryType.completedTasks;
                });
              },
              value: QueryType.completedTasks,
              child: Text(
                "Complete",
                style: TextStyles.title,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                setState(() {
                  listType = QueryType.incompleteTasks;
                });
              },
              value: QueryType.incompleteTasks,
              child: Text(
                "inComplete ",
                style: TextStyles.title,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                setState(() {
                  listType = QueryType.allTasks;
                });
              },
              value: QueryType.allTasks,
              child: Text(
                "Clear Filter",
                style: TextStyles.title,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget taskData({
    required BuildContext context,
    required Task task,
  }) {
    return (InkWell(
        onTap: () {
          _showDialog(context, task);
        },
        child: Container(
            padding: const EdgeInsets.only(top: 16),
            height: 95,
            width: 325,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: AppColors.backgroundColor,
            ),
            child: ListTile(
              iconColor: AppColors.blue,
              leading: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  SvgPicture.asset(AppData.getIconDataString(task.dropDownValue)),
                ],
              ),
              title: Text(task.title,
                  style: TextStyle(
                    color: Color(0XFF0C1A30),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                  )),
              subtitle: Text(task.description,
                  style: TextStyle(
                    color: Color(0XFF0C1A30),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                  )),
              trailing: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    task.createdAt.toString(),
                    style: TextStyles.body,
                  ),
                  const Spacer(),
                ],
              ),
            ))));
  }


  void _showDialog(BuildContext context, Task task) {
    // flutter defined function
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SafeArea(
            child: SizedBox(
          height: 150,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    taskController.delete(task.id!);
                    //_delete(context, task.id!);
                    if (mounted) Navigator.pop(context);

                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.homePageColors),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text('Delete', style: TextStyles.deleteButton),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await taskController.onTaskDone(task);
                    if (mounted) Navigator.pop(context);
                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text('Complete this Task', style: TextStyles.bottomSheetButton),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }


}





// Future<void> _refreshTasks() async {
//   await _taskController.getTasks(queryType);
// }
//
// void setQueryType({required QueryType query}) {
//   queryType = query;
//   _refreshTasks();
//   setState(() {});
// }

//
// @override
// void initState() {
//   super.initState();
//   _updateNoteList();
// //  _delete(context, DatabaseHelper.instance.colId.length);
//   taskController.databaseHelper.getLastTodoTask();
// }
//
// final taskController = TasksController();
//
// _updateNoteList() {
//   task = taskController.getAllTasks();
// }