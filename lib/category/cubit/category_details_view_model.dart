import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/category/cubit/states.dart';

class CategoryDetailsViewModel extends Cubit<CategorySourceState> {
  CategoryDetailsViewModel() : super(SourceLoadingState());

  getSourceByCategoryId(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await ApiManager.getData(categoryId);
      if (response.status == 'error') {
        emit(SourceErrorState(errorMsg: response.message));
      } else {
        emit(SourceSuccessState(sourcesList: response.sources));
      }
    } catch (e) {
      emit(SourceErrorState(errorMsg: 'Error loading sources list'));
    }
  }
}
