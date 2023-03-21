import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/app_colors.dart';
import 'package:todo_list_app/utils/form_validation_form.dart';
import 'package:todo_list_app/utils/text_styles.dart';

class TitleTextField extends StatelessWidget {
   TitleTextField({Key? key}) : super(key: key);
  final TextEditingController titleC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
