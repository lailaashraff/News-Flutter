import 'package:flutter/material.dart';
import 'package:news_app/components/news_container.dart';
import 'package:news_app/components/tab_item.dart';

import '../models/SourceResponse.dart';

class TabContainer extends StatefulWidget {
  List<Source> sourceList;

  TabContainer({required this.sourceList});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.transparent,
            isScrollable: true,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            tabs: widget.sourceList.map((source) {
              return TabItem(
                  source: source,
                  isSelected:
                      selectedIndex == widget.sourceList.indexOf(source));
            }).toList(),
          ),
          Expanded(
              child: NewsContainer(source: widget.sourceList[selectedIndex]))
        ],
      ),
    );
  }
}
