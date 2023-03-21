import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/app_colors.dart';
import 'package:todo_list_app/utils/app_data.dart';
import 'package:todo_list_app/utils/text_styles.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({Key? key}) : super(key: key);

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}
final TextEditingController typeC = TextEditingController();
String dropDownValue = 'Birthday';

class _DropDownFieldState extends State<DropDownField> {
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
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
    );
  }
}
