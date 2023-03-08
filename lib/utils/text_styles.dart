import 'package:flutter/material.dart';

class TextStyles{
  static const title = TextStyle(
    color: Color(0XFF0C1A30),
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: "Poppins",
  );

  static const subtitle = TextStyle(
    color: Color(0XFF0C1A30),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
  );

  static const subtitle1 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
  );

  static  TextStyle body = TextStyle(
    color: Colors.grey.shade600,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: "Poppins",
  );


  static const textField = TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontFamily: "Poppins",
    height: 1.2,
  );

  static  TextStyle body1 = TextStyle(
    color: Colors.grey.shade600,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: "Poppins",
  );

    static  const  bottomSheetButton = TextStyle(
      color: Colors.white,
    //fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
  );

  static  const  deleteButton = TextStyle(
    color: Colors.red,
    //fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
  );
}
