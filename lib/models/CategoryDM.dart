import 'package:flutter/material.dart';
import 'package:news_app/my_theme.dart';

class CategoryDM {
  String title;
  String id;
  Color color;
  String image;

  CategoryDM(
      {required this.id,
      required this.title,
      required this.color,
      required this.image});

  /*




     technology
   */
  static List<CategoryDM> getCategories() {
    return [
      CategoryDM(
          id: 'sports',
          title: 'Sports',
          color: MyTheme.redColor,
          image: 'assets/images/sports.png'),
      CategoryDM(
          id: 'general',
          title: 'General',
          color: MyTheme.darkBlueColor,
          image: 'assets/images/Politics.png'),
      CategoryDM(
          id: 'health',
          title: 'Health',
          color: MyTheme.pinkColor,
          image: 'assets/images/health.png'),
      CategoryDM(
          id: 'business',
          title: 'Business',
          color: MyTheme.brownColor,
          image: 'assets/images/bussines.png'),
      CategoryDM(
          id: 'entertainment',
          title: 'Entertainment',
          color: MyTheme.blueColor,
          image: 'assets/images/environment.png'),
      CategoryDM(
          id: 'science',
          title: 'Science',
          color: MyTheme.yellowColor,
          image: 'assets/images/science.png'),
      CategoryDM(
          id: 'technology',
          title: 'Technology',
          color: MyTheme.grayColor,
          image: 'assets/images/technology.png'),
    ];
  }
}
