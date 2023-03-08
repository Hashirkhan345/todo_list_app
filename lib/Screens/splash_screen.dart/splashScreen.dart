import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';
import '../HomePage/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  const HomePage ())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          const SizedBox(
            height: 180,
          ),
          Container(
            margin: const EdgeInsets.only(left: 150, right: 150),
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
          const SizedBox(
            height: 35,
          ),
          const Center(
            child: Text(
              "Welcome to",
              style: TextStyles.title,
            ),
          ),
          const Center(
            child: Text(
              "My Todo",
              style: TextStyles.subtitle,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Text(
              "My Todo helps ypu stay organized and  ",
              style: TextStyles.body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 40),
            child: Text(
              " perform your tasks much faster.",
              style: TextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}
