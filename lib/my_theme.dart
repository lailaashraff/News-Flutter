import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff39A552);
  static Color redColor = Color(0xffC91C22);
  static Color darkBlueColor = Color(0xff003E90);
  static Color pinkColor = Color(0xffED1E79);
  static Color brownColor = Color(0xffCF7E48);
  static Color blueColor = Color(0xff4882CF);
  static Color yellowColor = Color(0xffF2D352);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color grayColor = Color(0xFF595757);
  static Color darkGrayColor = Color(0xFF4F5A69);

  static ThemeData lightMode = ThemeData(
      primaryColor: primaryLight,
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: whiteColor),
          backgroundColor: primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          )),
      inputDecorationTheme: InputDecorationTheme(
        activeIndicatorBorder: BorderSide.none,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: whiteColor),
        titleSmall: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: grayColor,
        ),
      ));
}
