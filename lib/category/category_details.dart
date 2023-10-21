import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/category/cubit/category_details_view_model.dart';
import 'package:news_app/category/cubit/states.dart';
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
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSourceByCategoryId(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsViewModel, CategorySourceState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is SourceLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryLight,
              ),
            );
          } else if (state is SourceErrorState) {
            return Column(
              children: [
                Text(state.errorMsg!),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getSourceByCategoryId(widget.category.id);
                    setState(() {});
                  },
                  child: Text('Try again'),
                )
              ],
            );
          } else if (state is SourceSuccessState) {
            return TabContainer(sourceList: state.sourcesList!);
          }
          return Container();
        });

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
    //     var sourcesList = snapshot.data?.sources ?? [];
    //     return TabContainer(sourceList: sourcesList);
    //   },
    // );

    // return ChangeNotifierProvider(
    //   create: (context) => viewModel,
    //   child: Consumer<CategoryDetailsViewModel>(
    //     builder: (context, viewModel, child) {
    //       if (viewModel.errorMessage != null) {
    //         return Column(
    //           children: [
    //             Text(viewModel.errorMessage!),
    //             ElevatedButton(
    //               onPressed: () {
    //                 viewModel.getSources(widget.category.id);
    //               },
    //               child: Text('Try again'),
    //             )
    //           ],
    //         );
    //       } else if (viewModel.sourceList == null) {
    //         return Center(
    //           child: CircularProgressIndicator(
    //             color: MyTheme.primaryLight,
    //           ),
    //         );
    //       } else {
    //         return TabContainer(sourceList: viewModel.sourceList!);
    //       }
    //     },
    //   ),
    // );
  }
}
