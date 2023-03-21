import 'package:flutter/material.dart';
import 'package:todo_list_app/my_todo/data/model/task.dart';

import 'package:todo_list_app/utils/app_colors.dart';
import 'package:todo_list_app/utils/app_data.dart';
import 'package:todo_list_app/utils/form_validation_form.dart';
import 'package:todo_list_app/utils/text_styles.dart';

import '../../../data/repository/my_todo_repository/list_todo.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  DateTime dateTime = DateTime.now();

  // Initial Selected Value

  final GlobalKey<FormState> _formKey = GlobalKey();

  String dropDownValue = 'Birthday';

  final TasksController taskController = TasksController();
  final TextEditingController titleC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController typeC = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _submit();
          },
          backgroundColor: AppColors.splashContainer,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.splashContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: AppColors.backgroundColor,
                size: 30,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text(
            "Add New Items",
            style: TextStyles.subtitle,
          ),
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.menuColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (title) => FormValidatorHelper.validateTitle(title!),
                    controller: titleC,
                    maxLines: 3,
                    obscureText: false,
                    decoration: InputDecoration(
                      fillColor: AppColors.backgroundColor,
                      filled: true,
                      hintText: 'Enter your Title',
                      hintStyle: TextStyles.textField,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderSide)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderSide)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (description) => FormValidatorHelper.validateDescription(description!),
                    controller: descriptionC,
                    maxLines: 3,
                    obscureText: false,
                    decoration: InputDecoration(
                      fillColor: AppColors.backgroundColor,
                      filled: true,
                      hintText: 'Enter your description',
                      hintStyle: TextStyles.textField,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderSide)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderSide)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: typeC,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: DropdownButton(
                          underline: Container(
                            color: AppColors.backgroundColor,
                          ),
                          items: AppData.todoTypes.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              typeC.text = newValue!;
                            });
                          },
                        ),
                      ),
                      fillColor: AppColors.backgroundColor,
                      filled: true,
                      hintText: dropDownValue,
                      hintStyle: TextStyles.textField,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderSide)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderSide)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ));
  }

  static String timeAgo(DateTime fetchedDate) {
    DateTime currentDate = DateTime.now();
    var different = currentDate.difference(fetchedDate);
    if (different.inDays > 365) {
      return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (different.inDays > 30) {
      return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (different.inDays > 7) {
      return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (different.inDays > 0) {
      return "${different.inDays} ${different.inDays == 1 ? "day" : "days"} ago";
    }
    if (different.inHours > 0) {
      return "${different.inHours} ${different.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (different.inMinutes > 0) {
      return "${different.inMinutes} ${different.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    if (different.inMinutes == 0) return 'Just Now';
    return fetchedDate.toString();
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final task = Task(
        title: titleC.text,
        description: descriptionC.text.trim(),
        dropDownValue: typeC.text.trim(),
        status: 0,
        // createdAt: Jiffy(dateTime).fromNow(),

         createdAt: timeAgo(DateTime.now()),
        // createdAt:   Jiffy(DateTime.now()).fromNow(),// 8 years ago
        // createdAt:  Jiffy().startOf(Units.HOUR).fromNow(), // 9 minutes ago
      );
      bool isInserted = await taskController.insertTask(newTask: task);

      /// mounted tell if you are still on current page
      if (mounted) {
        Navigator.pop(context, isInserted);
      }
    }
  }
}
