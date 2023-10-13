import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/models/CategoryDM.dart';
import 'package:news_app/my_theme.dart';
import 'package:news_app/tabs/tab_container.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category-screen';
  CategoryDM category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getData(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: MyTheme.primaryLight,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something went wrong'),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getData(widget.category.id);
                  setState(() {});
                },
                child: Text('Try again'),
              )
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(snapshot.data?.message ?? ""),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getData(widget.category.id);
                  setState(() {});
                },
                child: Text('Try again'),
              )
            ],
          );
        }
        var sourcesList = snapshot.data?.sources ?? [];
        return TabContainer(sourceList: sourcesList);
      },
    );
  }
}
