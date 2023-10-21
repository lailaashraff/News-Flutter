import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/news/cubit/states.dart';

class NewsContainerViewModel extends Cubit<NewsStates> {
  NewsContainerViewModel() : super(NewsLoadingState());

  void getNewsArticlesBySourceId(String sourceId) async {
    try {
      emit(MessageState(msg: 'Loading...'));
      emit(NewsLoadingState());
      var response = await ApiManager.getNewsBySourceId(sourceId);
      if (response.status == 'error') {
        emit(NewsErrorState(errorMsg: response.message));
      } else {
        emit(NewsSuccessState(newsList: response.articles));
      }
    } catch (e) {
      emit(NewsErrorState(errorMsg: 'Error loading news list'));
    }
  }
}
