import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';

import '../models/SourceResponse.dart';

class CategoryDetailsViewModel extends ChangeNotifier {
  List<Source>? sourceList;
  String? errorMessage;

  Future<void> getSources(String categoryId) async {
    sourceList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getData(categoryId);
      if (response?.status == 'error') {
        errorMessage = response.message;
      } else {
        sourceList = response.sources;
      }
    } catch (e) {
      errorMessage = 'Error loading sources list';
    }
    notifyListeners();
  }
}
