import 'package:flutter/material.dart';

import '../api_manager.dart';
import '../my_theme.dart';
import '../news/news_article.dart';
import '../news/news_item.dart';

class NewSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => showResults(context), icon: Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Search for desired news !'),
      );
    }
    return FutureBuilder(
      future: ApiManager.getNewsBySearch(query),
      builder: (context, snapshot) {
        var newsList = snapshot.data?.articles ?? [];
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
                  ApiManager.getNewsBySearch(query);
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
                  ApiManager.getNewsBySearch(query);
                },
                child: Text('Try again'),
              )
            ],
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsArticle(news: newsList[index]),
                    ),
                  );
                },
                child: NewsItem(news: newsList[index]));
          },
          itemCount: newsList.length,
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return MyTheme.lightMode;
  }
}
