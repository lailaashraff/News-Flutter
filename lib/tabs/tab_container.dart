import 'package:flutter/material.dart';
import 'package:news_app/news/news_container.dart';
import 'package:news_app/tabs/tab_container_view_model.dart';
import 'package:news_app/tabs/tab_item.dart';
import 'package:provider/provider.dart';

import '../models/SourceResponse.dart';

class TabContainer extends StatefulWidget {
  List<Source> sourceList;

  TabContainer({required this.sourceList});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  TabContainerViewModel viewModel = TabContainerViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<TabContainerViewModel>(
        builder: (context, value, child) {
          return DefaultTabController(
            length: widget.sourceList.length,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  onTap: (index) {
                    viewModel.changeSelectedIndex(index);
                    setState(() {});
                  },
                  tabs: widget.sourceList.map((source) {
                    return TabItem(
                        source: source,
                        isSelected: viewModel.selectedIndex ==
                            widget.sourceList.indexOf(source));
                  }).toList(),
                ),
                Expanded(
                    child: NewsContainer(
                        source: widget.sourceList[viewModel.selectedIndex]))
              ],
            ),
          );
        },
      ),
    );
  }
}
