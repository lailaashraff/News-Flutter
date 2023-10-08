import 'package:flutter/material.dart';

import '../api_manager.dart';
import '../models/SourceResponse.dart';
import '../my_theme.dart';

class NewsContainer extends StatelessWidget {
  Source source;

  NewsContainer({required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getNewsBySourceId(source.id ?? ''),
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
                  ApiManager.getNewsBySourceId(source.id ?? '');
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
                  ApiManager.getNewsBySourceId(source.id ?? '');
                },
                child: Text('Try again'),
              )
            ],
          );
        }
        var newsList = snapshot.data?.articles ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            return Text(newsList[index].title ?? '');
          },
        );
      },
    );
  }
}
