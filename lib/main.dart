import 'package:flutter/material.dart';
import 'package:news_app/my_theme.dart';
import 'package:news_app/screens/category_details.dart';
import 'package:news_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      initialRoute: CategoryDetails.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CategoryDetails.routeName: (context) => CategoryDetails()
      },
    );
  }
}
