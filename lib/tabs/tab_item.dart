import 'package:flutter/material.dart';
import 'package:news_app/my_theme.dart';

import '../models/SourceResponse.dart';

class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;

  TabItem({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isSelected ? MyTheme.primaryLight : Colors.transparent,
        border: Border.all(width: 3, color: MyTheme.primaryLight),
      ),
      child: Text(
        source.name ?? '',
        style: TextStyle(
          fontSize: 20,
          color: isSelected ? MyTheme.whiteColor : MyTheme.primaryLight,
        ),
      ),
    );
  }
}
