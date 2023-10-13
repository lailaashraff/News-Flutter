import 'package:flutter/material.dart';
import 'package:news_app/models/CategoryDM.dart';
import 'package:news_app/my_theme.dart';

class CategoryItem extends StatelessWidget {
  CategoryDM category;
  int index;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(index % 2 == 0 ? 20 : 0),
            bottomRight: Radius.circular(index % 2 != 0 ? 20 : 0),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            category.image,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: MyTheme.whiteColor),
          )
        ],
      ),
    );
  }
}
