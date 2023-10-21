import 'package:flutter/material.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/my_theme.dart';
import 'package:news_app/tabs/tab_container_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TabContainerViewModel(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        //CategoryDetails.routeName: (context) => CategoryDetails()
      },
    );
  }
}
