import '../../models/SourceResponse.dart';

abstract class CategorySourceState {}

class SourceLoadingState extends CategorySourceState {}

class SourceInitialState extends CategorySourceState {}

class SourceErrorState extends CategorySourceState {
  String? errorMsg;

  SourceErrorState({required this.errorMsg});
}

class SourceSuccessState extends CategorySourceState {
  List<Source>? sourcesList;

  SourceSuccessState({required this.sourcesList});
}
