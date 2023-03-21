import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/app_colors.dart';
import 'package:todo_list_app/utils/form_validation_form.dart';
import 'package:todo_list_app/utils/text_styles.dart';

class DescriptionField extends StatelessWidget {
   DescriptionField({Key? key}) : super(key: key);

  final TextEditingController descriptionC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
