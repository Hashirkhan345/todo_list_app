
import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/app_colors.dart';
import 'package:todo_list_app/utils/text_styles.dart';

class ChallengeContainer extends StatelessWidget {
 final  String title;
   final   String description;
 final String  createdAt;
  const ChallengeContainer({Key? key, required this.title, required this.description, required this.createdAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 20),
      height: 105,
      width: 325,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.halfGreen,
      ),
      child: ListTile(
          leading: Column(
            children: [
              Icon(
                Icons.check_circle,
                size: 30,
                color: AppColors.green,
              ),
            ],
          ),
          title: Text(
            title,
            style: TextStyles.title,
          ),
          subtitle: Text(
            description,
            style: TextStyles.title,
          ),
          trailing: Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              Text(
                createdAt.toString(),
                style: TextStyles.body1,
              ),
            ],
          )),
    );
  }
}
