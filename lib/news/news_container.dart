import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/SourceResponse.dart';
import '../my_theme.dart';
import 'news_container_view_model.dart';
import 'news_item.dart';

class NewsContainer extends StatefulWidget {
  Source source;

  NewsContainer({required this.source});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsContainerViewModel viewModel = NewsContainerViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<NewsContainerViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return Column(
              children: [
                Text(viewModel.errorMessage!),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getNewsBySourceId(widget.source.id ?? "");
                  },
                  child: Text('Try again'),
                )
              ],
            );
          } else if (viewModel.newsList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryLight,
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: viewModel.newsList![index]);
              },
              itemCount: viewModel.newsList?.length,
            );
          }
        },
      ),
    );

    //   FutureBuilder(
    //   future: ApiManager.getNewsBySourceId(source.id ?? ''),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: MyTheme.primaryLight,
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Column(
    //         children: [
    //           Text('Something went wrong'),
    //           ElevatedButton(
    //             onPressed: () {
    //               ApiManager.getNewsBySourceId(source.id ?? '');
    //             },
    //             child: Text('Try again'),
    //           )
    //         ],
    //       );
    //     }
    //     if (snapshot.data?.status != 'ok') {
    //       return Column(
    //         children: [
    //           Text(snapshot.data?.message ?? ""),
    //           ElevatedButton(
    //             onPressed: () {
    //               ApiManager.getNewsBySourceId(source.id ?? '');
    //             },
    //             child: Text('Try again'),
    //           )
    //         ],
    //       );
    //     }
    //     var newsList = snapshot.data?.articles ?? [];
    //     return ListView.builder(
    //       itemBuilder: (context, index) {
    //         return InkWell(
    //             onTap: () {}, child: NewsItem(news: newsList[index]));
    //       },
    //       itemCount: newsList.length,
    //     );
    //   },
    // );
  }
}
