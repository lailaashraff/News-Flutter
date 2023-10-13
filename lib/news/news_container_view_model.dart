import 'package:flutter/cupertino.dart';
import 'package:news_app/api_manager.dart';

import '../models/NewsResponse.dart';

class NewsContainerViewModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;

  Future<void> getNewsBySourceId(String sourceId) async {
    newsList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getNewsBySourceId(sourceId);
      if (response.status == 'error') {
        errorMessage = response.message;
      } else {
        newsList = response.articles;
      }
    } catch (e) {
      errorMessage = 'Error loading source list';
    }
    notifyListeners();
  }
}
