import '../../models/NewsResponse.dart';

abstract class NewsStates {}

//build
class NewsLoadingState extends NewsStates {}

class NewsErrorState extends NewsStates {
  String? errorMsg;

  NewsErrorState({required this.errorMsg});
}

class NewsSuccessState extends NewsStates {
  List<News>? newsList;

  NewsSuccessState({required this.newsList});
}

//actions
class MessageState extends NewsStates {
  String? msg;

  MessageState({required this.msg});
}
