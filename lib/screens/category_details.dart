import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/components/tab_container.dart';
import 'package:news_app/my_theme.dart';

class CategoryDetails extends StatelessWidget {
  static const String routeName = 'category-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiManager.getData(),
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
                    ApiManager.getData();
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
                    ApiManager.getData();
                  },
                  child: Text('Try again'),
                )
              ],
            );
          }
          var sourcesList = snapshot.data?.sources ?? [];
          return TabContainer(sourceList: sourcesList);
        },
      ),
    );
  }
}
