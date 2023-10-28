import 'package:flutter/material.dart';
import 'package:news_app/news/cubit/news_container_view_model.dart';
import 'package:news_app/news/news_article.dart';

import '../api_manager.dart';
import '../models/SourceResponse.dart';
import '../my_theme.dart';
import 'news_item.dart';

class NewsContainer extends StatefulWidget {
  Source source;
  NewsContainer({required this.source});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsContainerViewModel viewModel = NewsContainerViewModel();
  ScrollController scrollController = ScrollController();
  late var newsList;
  bool hasMore = true;
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent
      ) {
        fetchMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<NewsContainerViewModel,NewsStates>(
    //   bloc: viewModel,
    //      listener: (context, state) {
    //        if(state is MessageState){
    //          DialogUtils.showLoading(context, 'Loading');
    //        }
    //      },
    //   listenWhen: (previousState, newState){
    //     if(newState is MessageState){
    //       return true;
    //     }
    //     return false;
    //   },
    //   buildWhen: (previousState,newState){
    //     if(newState is MessageState){
    //       return false;
    //     }
    //     return true;
    //   },
    //   builder: (context, state) {
    //     if (state is NewsLoadingState) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: MyTheme.primaryLight,
    //         ),
    //       );
    //     }
    //     else if(state is NewsErrorState){
    //       return Column(
    //         children: [
    //           Text(state.errorMsg!),
    //           ElevatedButton(
    //             onPressed: () {
    //               viewModel.getNewsArticlesBySourceId(widget.source.id!);
    //               setState(() {});
    //             },
    //             child: Text('Try again'),
    //           )
    //         ],
    //       );
    //     }
    //     else if(state is NewsSuccessState){
    //       return ListView.builder(
    //                 itemBuilder: (context, index) {
    //                   return InkWell(
    //                       onTap: () {}, child: NewsItem(news: state.newsList![index]));
    //                 },
    //                 itemCount: state.newsList!.length,
    //               );
    //     }
    //     return Container();
    //
    //   },);
    return FutureBuilder(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
      builder: (context, snapshot) {
        newsList = snapshot.data?.articles ?? [];
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
                  ApiManager.getNewsBySourceId(widget.source.id ?? '');
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
                  ApiManager.getNewsBySourceId(widget.source.id ?? '');
                },
                child: Text('Try again'),
              )
            ],
          );
        }

        return ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < newsList.length) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsArticle(news: newsList[index]),
                      ),
                    );
                    setState(() {});
                  },
                  child: NewsItem(news: newsList[index]));
            } else {
              return Center(
                  child: hasMore
                      ? CircularProgressIndicator(
                          color: MyTheme.primaryLight,
                        )
                      : Text('No More Data To Load'));
            }
          },
          itemCount: newsList.length + 1,
        );
      },
    );

    // return ChangeNotifierProvider(
    //   create: (context) => viewModel,
    //   child: Consumer<NewsContainerViewModel>(
    //     builder: (context, viewModel, child) {
    //       if (viewModel.errorMessage != null) {
    //         return Column(
    //           children: [
    //             Text(viewModel.errorMessage!),
    //             ElevatedButton(
    //               onPressed: () {
    //                 viewModel.getNewsBySourceId(widget.source.id ?? "");
    //               },
    //               child: Text('Try again'),
    //             )
    //           ],
    //         );
    //       } else if (viewModel.newsList == null) {
    //         return Center(
    //           child: CircularProgressIndicator(
    //             color: MyTheme.primaryLight,
    //           ),
    //         );
    //       } else {
    //         return ListView.builder(
    //           itemBuilder: (context, index) {
    //             return NewsItem(news: viewModel.newsList![index]);
    //           },
    //           itemCount: viewModel.newsList?.length,
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  Future fetchMore() async {
    if (isLoading) return;
    isLoading = true;

    var newsResponse = await ApiManager.getNewsBySourceId(widget.source.id!);
    setState(() {
      newsList.addAll(newsResponse.articles!);
      if (newsList.length < ApiManager.pageLimit) {
        hasMore = false;
      }
    });
    ApiManager.currentPage++;
    isLoading = false;
  }


}
