import 'package:flutter/cupertino.dart';

class TabContainerViewModel extends ChangeNotifier {
  int selectedIndex = 0;

  void changeSelectedIndex(int newSelectedIndex) {
    if (selectedIndex == newSelectedIndex) {
      return;
    }
    selectedIndex = newSelectedIndex;
    notifyListeners();
  }
}
