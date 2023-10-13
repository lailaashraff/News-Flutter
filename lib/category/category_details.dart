import 'package:flutter/material.dart';
import 'package:news_app/category/category_details_view_model.dart';
import 'package:news_app/models/CategoryDM.dart';
import 'package:news_app/my_theme.dart';
import 'package:news_app/tabs/tab_container.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category-screen';
  CategoryDM category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<CategoryDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return Column(
              children: [
                Text(viewModel.errorMessage!),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getSources(widget.category.id);
                  },
                  child: Text('Try again'),
                )
              ],
            );
          } else if (viewModel.sourceList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryLight,
              ),
            );
          } else {
            return TabContainer(sourceList: viewModel.sourceList!);
          }
        },
      ),
    );
    // return FutureBuilder(
    //   future: ApiManager.getData(widget.category.id),
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
    //               ApiManager.getData(widget.category.id);
    //               setState(() {});
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
    //               ApiManager.getData(widget.category.id);
    //               setState(() {});
    //             },
    //             child: Text('Try again'),
    //           )
    //         ],
    //       );
    //     }
    //     //var sourcesList = snapshot.data?.sources ?? [];
    //     return TabContainer(sourceList: sourcesList);
    //   },
    // );
  }
}
