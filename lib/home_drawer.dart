import 'package:flutter/material.dart';

import 'my_theme.dart';

class HomeDrawer extends StatelessWidget {
  static const int categories = 1;
  static const int settings = 2;

  Function onSideTap;

  HomeDrawer({required this.onSideTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
              color: MyTheme.primaryLight,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.09,
              ),
              child: Text(
                'News App !',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            InkWell(
              onTap: () {
                onSideTap(categories);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.list_sharp),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                onSideTap(settings);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Settings',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
